//
//  LoadFriendsOperation.swift
//  notVK
//
//  Created by Roman on 13.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class LoadFriendsOperation: AsyncOperation {
    override func cancel() {
        //request.cancel()
        super.cancel()
    }
    //TODO: Realise URLSession data request
    
//    private var urlComponents = URLComponents()
//    urlComponents.scheme = "https"
//    urlComponents.host = "api.vk.com"
//    urlComponents.path = "/method/photos.get"
//    urlComponents.queryItems = [
//        URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
//        URLQueryItem(name: "extended", value: "1"),
//        URLQueryItem(name: "v", value: "5.103"),
//        URLQueryItem(name: "album_id", value: "profile"),
//        URLQueryItem(name: "owner_id", value: friendId)
//    ]
//
//    private var request: DataRequest = Alamofire.request("https://jsonplaceholder.typicode.com/posts")
//    var data: Data?
//
//    override func main() {
//        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
//            self?.data = response.data
//            self?.state = .finished
//        }
//    }
    
}
