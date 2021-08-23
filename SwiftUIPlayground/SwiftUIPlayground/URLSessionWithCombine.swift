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
