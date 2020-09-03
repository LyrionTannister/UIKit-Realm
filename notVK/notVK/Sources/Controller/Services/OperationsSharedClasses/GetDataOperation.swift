//
//  GetDataOperation.swift
//  notVK
//
//  Created by Roman on 13.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GetDataOperation: AsyncOperation {

    private var urlConstructor = URLComponents()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private var urlRequest: URLRequest
    private var task: URLSessionTask?
    
    var data: Data?
    
    init(urlRequest: URLRequest) {
        
        urlConstructor.scheme = VKDataSelector.shared.scheme
        urlConstructor.host = VKDataSelector.shared.host
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = URLSession(configuration: configuration)
        
        self.urlRequest = urlRequest
        super.init()
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }

    override func main() {
        task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            DispatchQueue.global().async {
                if let error = error {
                    print(error)
                    self?.state = .finished
                    return
                }
                
                guard let data = data else {
                    self?.state = .finished
                    return
                }
                
                self?.data = data
                self?.state = .finished
            }
        }
        task?.resume()
    }

}
