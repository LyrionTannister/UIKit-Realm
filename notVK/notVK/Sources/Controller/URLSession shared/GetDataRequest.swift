//
//  GetDataRequest.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

func getMyFriends() {
    
    let downloader: GetDataRequest = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return GetDataRequest(configuration: config)
    }()
    
    var urlComponents = URLComponents()
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
    
    downloader.getData(urlRequest: getFriendsReqest) { data in
        if let d = data {
            let im = Data(base64Encoded: d)
            print(im) // assume we're called back on main thread
        }
    }
}

class GetDataRequest: NSObject {
    
    typealias GetDataCH = (Data?) -> ()
    
    //var data = [Int:Data]()
    let config: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.config,
                          delegate: GetDataRequestDelegate(),
                          delegateQueue: .main)
    }()
    
    init(configuration config: URLSessionConfiguration) {
        self.config = config
        super.init()
    }
    
    @discardableResult
    func getData(urlRequest: URLRequest,
                 completionHandler ch : @escaping GetDataCH) -> URLSessionTask {
        
        let task = self.session.dataTask(with: urlRequest)
        let delegate = self.session.delegate as! GetDataRequestDelegate
        delegate.appendHandler(ch, task: task)
        
        task.resume()
        return task
    }
    
    
    deinit {
        self.session.invalidateAndCancel()
    }
}
