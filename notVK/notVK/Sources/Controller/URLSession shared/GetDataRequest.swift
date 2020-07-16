//
//  GetDataRequest.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

let downloader: GetDataRequest = {
 let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30
 return GetDataRequest(configuration: config)
}()

let s = "https://www.someserver.com/somefolder/someimage.jpg"
let url = URL(string:s)!
let req = URLRequest(url: url)
downloader.getData(urlRequest: req) { url in
    if let url = url, let d = try? Data(contentsOf: url) {
        let im = UIImage(data: d)
        print(im) // assume we're called back on main thread
    }
}

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
        let delegate = self.session.delegate!
        delegate.appendHandler(ch, task: task)
        
        task.resume()
        return task
    }
    
    
    deinit {
        self.session.invalidateAndCancel()
    }
}

class GetDataRequestDelegate: NSObject, URLSessionDelegate {
    
    typealias GetDataCH = (URLRequest?) -> ()
    
    private var handlers = [Int:GetDataCH]()
    
    func appendHandler(_ ch: @escaping GetDataCH, task: URLSessionTask) {
        self.handlers[task.taskIdentifier] = ch
    }
    
    func urlSession(_ session: URLSession,
                    dataTask getDataTask: URLSessionDataTask,
                    didReceive data: Data) {
        let ch = self.handlers[getDataTask.taskIdentifier]
        
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        let ch = self.handlers[task.taskIdentifier]
        self.handlers[task.taskIdentifier] = nil
        if error == nil {
            ch?(nil)
        }
    }

}
