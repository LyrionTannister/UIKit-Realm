//
//  GetDataRequest.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

//let downloader: GetDataRequest = {
// let config = URLSessionConfiguration.default
//    config.timeoutIntervalForRequest = 30
// return GetDataRequest(configuration: config)
//}()
//
//let s = "https://www.someserver.com/somefolder/someimage.jpg"
//let url = URL(string:s)!
//let req = URLRequest(url: url)
//downloader.getData(urlRequest: req) { data in
//    if let d = data {
//        let im = UIImage(data: d)
//        print(im) // assume we're called back on main thread
//    }
//}

class GetDataRequest: NSObject {
    
    typealias DownloaderCH = (URLRequest?) -> ()
    
    var data = [Int:Data]()
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
                 completionHandler ch : @escaping DownloaderCH) -> URLSessionTask {
        
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
