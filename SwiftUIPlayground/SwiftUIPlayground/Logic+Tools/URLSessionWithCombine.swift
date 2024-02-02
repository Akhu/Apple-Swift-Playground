//
//  URLSessionWithCombine.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 17/08/2021.
//

import Foundation
import UIKit
import Combine

class NetworkDataLoader: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    //https://i.picsum.photos/id/237/500/500.jpg?hmac=idOEkrJhLd7nEU5pNrAGCyJ6HHJdR_sit1qDt5J3Wo0
    func downloadImage(url: URL) -> AnyPublisher<UIImage, Never>{
       return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { data, response in
                UIImage(data: data)
            }
            .replaceNil(with: UIImage(named: "placeholder")!)
            .replaceError(with: UIImage(named: "placeholder")!)
            .eraseToAnyPublisher()
    }
}

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

extension String {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var stringDate: Date? {
        return String.shortDate.date(from: self)
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason:String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error occurred"
        case .apiError(let reason), .parserError(let reason):
            return reason
        }
    }
}

func fetch(url: URL) -> AnyPublisher<Data, APIError> {
    let request = URLRequest(url: url)
    
    return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.unknown
            }
            return data
        }
        .mapError { error in
            if let error = error as? APIError {
                return error
            } else {
                return APIError.apiError(reason: error.localizedDescription)
            }
        }
        .eraseToAnyPublisher()
}

func fetch<T: Decodable>(url: URL, prefix: Int = 10) -> AnyPublisher<T, APIError> {
    fetch(url: url)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error in
            if let error = error as? DecodingError {
                var errorToReport = error.localizedDescription
                switch error {
                case .dataCorrupted(let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) - (\(details))"
                case .keyNotFound(let key, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (key: \(key), (\(details))"
                case .typeMismatch(let type, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (type: \(type), (\(details))"
                case .valueNotFound(let type, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (type: \(type), (\(details))"
                @unknown default:
                    break
                }
                return APIError.parserError(reason: errorToReport)
            } else {
                return APIError.apiError(reason: error.localizedDescription)
            }
        }.eraseToAnyPublisher()
}
