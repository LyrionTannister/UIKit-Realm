//
//  GetDataRequest.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GetDataRequest: NSObject {
    
    typealias GetDataCH = (Data?) -> ()
    
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
                 completionHandler ch : @escaping GetDataCH) -> URLSessionDataTask {
        
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
