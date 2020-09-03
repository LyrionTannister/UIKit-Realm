//
//  PromiseNetworkService.swift
//  notVK
//
//  Created by Roman on 03.08.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

class PromiseNetworkService{
    
    static func VKRequestPromise<T:Codable> (with urlRequestFor: URLRequest) -> Promise<[T]> {

        let configuration: URLSessionConfiguration!
        let session: URLSession!
        var urlRequest: URLRequest
        var task: URLSessionTask?
        
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = URLSession(configuration: configuration)
        
        urlRequest = urlRequestFor
        
        return Promise { resolver in
            task = session.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.global().async {
                    
                    if let error = error {
                        print(error)
                        resolver.reject(error)
                        return
                    }
                    
                    guard let data = data else {
                        resolver.reject("No data" as! Error)
                        return
                    }
                    
                    do {
                        let dataParsed = try JSONDecoder().decode(VKResponse<T>.self, from: data).response.items
                        resolver.fulfill(dataParsed)
                    } catch {
                        print (error)
                    }
                }
            }
            task?.resume()
         }
    }
}
