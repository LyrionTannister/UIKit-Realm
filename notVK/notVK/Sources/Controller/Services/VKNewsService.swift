//
//  VKNewsService.swift
//  notVK
//
//  Created by Roman on 25.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class VKNewsService {
    func loadNews(completion: @escaping (Result<NewsItems, Error>) -> Void) {
        
        DispatchQueue.global().async {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/newsfeed.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
                URLQueryItem(name: "filters", value: "post"),
                URLQueryItem(name: "start_from", value: "next_from"),
                URLQueryItem(name: "count", value: "100"),
                URLQueryItem(name: "v", value: "5.103"),
            ]
            let request = URLRequest(url: urlComponents.url!)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let news = try JSONDecoder().decode(NewsResponseNews.self, from: data)
                    //RealmRequestService.shared.deleteObjects(NewsItem.self)
                    //RealmRequestService.shared.commitObjects(news.response.items)
                    completion(.success(news.response))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }
    }
}
