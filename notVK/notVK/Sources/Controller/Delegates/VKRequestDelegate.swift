//
//  VKRequestDelegate.swift
//  notVK
//
//  Created by Roman on 14.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class VKRequestDelegate {
    static func loginRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7466203"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    static func loadGroups(completion: @escaping (Result<[GroupItem], Error>) -> Void ) {
        let urlString = VKDataSelector.shared.baseUrl + VKDataSelector.Method.getGroups.methodName + "?access_token=\(Session.shared.token)&extended=1&v=5.103"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let group = try JSONDecoder().decode(GroupResponse.self, from: data)
                    RealmRequestDelegate.shared.deleteObjects(GroupItem.self)
                    RealmRequestDelegate.shared.commitObjects(group.response.items)
                    completion(.success(group.response.items))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    static func loadFriends(completion: @escaping (Result<[FriendItem], Error>) -> Void) {
        let urlString = VKDataSelector.shared.baseUrl + VKDataSelector.Method.getFriends.methodName + "?access_token=\(Session.shared.token)&extended=1&v=5.103&fields=photo_100"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let friend = try JSONDecoder().decode(FriendResponse.self, from: data)
                    RealmRequestDelegate.shared.deleteObjects(FriendItem.self)
                    RealmRequestDelegate.shared.commitObjects(friend.response.items)
                    completion(.success(friend.response.items))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    static func loadFriendPhoto(friendId: String, completion: @escaping (Result<PhotoResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: friendId)
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let photo = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    completion(.success(photo))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    static func loadNews(completion: @escaping (Result<[NewsItem], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_from", value: "next_from"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "v", value: "5.103"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let photo = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    completion(.success(photo))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
        //--------
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let news = try? JSONDecoder().decode(Response<NewsModel>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(news)
            }
        }
        task.resume()
    }
}
