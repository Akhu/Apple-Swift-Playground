//
//  HackerNewsState.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 22/03/2023.
//

import Foundation
import Combine

struct HNItem: Codable {
    let by: String
    let descendants, id: Int
    let kids: [Int]
    let score: Int
    let text: String
    let time: Int
    let title, type: String
    let url: String
}

enum HNUrl:String {
    case topStories = "/topstories.json"
    case item = "/item"
    case apiPrefix = "/v0"
}

class HackerNewsState: ObservableObject {
    @Published var stories = [HNItem]()
    @Published var itemIdList = [Int]()
    
    var cancellables = Set<AnyCancellable>()
    
    func loadTopStories(limit:Int = 10) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = "hacker-news.firebaseio.com"
        urlBuilder.path = HNUrl.apiPrefix.rawValue + HNUrl.topStories.rawValue
        
        fetch(url: urlBuilder.url!, prefix: limit)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion, let apiError = error as? APIError {
                    print(error)
                    print(apiError ?? "")
                }
            }, receiveValue: { (model: [Int]) in
                print(model.prefix(10))
                print(model)
            }).store(in: &cancellables)
            
    }
}
