//
//  VKRequestService.swift
//  notVK
//
//  Created by Roman on 14.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class VKRequestService {
    
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

    static func loadGroups(ch: @escaping (Result<[GroupItem], Error>) -> Void ) {
        //MARK: TODO: Rewrite old method
//        var urlComponents = URLComponents()
//        urlComponents.scheme = VKDataSelector.shared.scheme
//        urlComponents.host = VKDataSelector.shared.host
//        urlComponents.path = VKDataSelector.Method.getGroups.methodName
//        urlComponents.queryItems = [
//            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
//            URLQueryItem(name: "extended", value: "1"),
//            URLQueryItem(name: "v", value: VKDataSelector.shared.apiVersion)
//        ]
//        let getGroupsReqest = URLRequest(url: urlComponents.url!)
//
//        //OLD METHOD
//        URLSession.shared.dataTask(with: getGroupsReqest) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("some error")
//                    ch(.failure(error))
//                    return
//                }
//                guard let data = data else { return }
//                do {
//                    let group = try JSONDecoder().decode(GroupResponse.self, from: data)
//                    RealmRequestService.shared.deleteObjects(GroupItem.self)
//                    RealmRequestService.shared.commitObjects(group.response.items)
//                    ch(.success(group.response.items))
//                } catch let jsonError {
//                    print("FAILED TO DECODE JSON", jsonError)
//                    ch(.failure(jsonError))
//                }
//            }
//        }.resume()
    }


    static func loadFriendPhoto(friendId: String, completion: @escaping (Result<PhotoResponse, Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = VKDataSelector.shared.scheme
        urlComponents.host = VKDataSelector.shared.host
        urlComponents.path = VKDataSelector.Method.getPhotos.methodName
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: friendId)
        ]
        
        let getPhotoRequest = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: getPhotoRequest) { (data, response, error) in
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
}
