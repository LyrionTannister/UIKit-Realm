//
//  LoadFriendsOperation.swift
//  notVK
//
//  Created by Roman on 13.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class LoadFriendsOperation: AsyncOperation {

    var data: Data?
    
    var urlComponents = urlComponents()
    urlComponents.scheme = VKDataSelector.shared.scheme
    urlComponents.host = VKDataSelector.shared.host
    urlComponents.path = VKDataSelector.Method.getFriends.methodName
    urlComponents.queryItems = [
        URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
        URLQueryItem(name: "extended", value: "1"),
        URLQueryItem(name: "fields", value: "photo_100"),
        URLQueryItem(name: "v", value: "5.103")
    ]
    let getFriendsReqest = URLRequest(url: urlComponents.url!)

    override func cancel() {
        //request.cancel()
        super.cancel()
    }

    override func main() {
        URLSession.shared.dataTask(with: getFriendsReqest) { [weak self] (data, response, error) in
            DispatchQueue.shared.async {
                if let error = error {
                    print("some error")
                    self?.state = .finished
                    return
                }
                guard let data = data else { return }
                self?.data = data
                self?.state = .finished
            }
        }.resume()
    }
    
}
