//
//  GetDataRequestDelegate.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GetDataRequestDelegate: NSObject, URLSessionDataDelegate {
    
    typealias GetDataCH = (Data?) -> ()
    
    private var handlers = [Int:GetDataCH]()
    private var data = [Int:Data]()
    
    func appendHandler(_ ch: @escaping GetDataCH, task: URLSessionTask) {
        self.handlers[task.taskIdentifier] = ch
    }
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        self.data[dataTask.taskIdentifier]!.append(data)
        //let ch = self.handlers[getDataTask.taskIdentifier]
        //ch?(data)
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        let ch = self.handlers[task.taskIdentifier]
        guard let receivedData = self.data[task.taskIdentifier] else { return }
        self.handlers[task.taskIdentifier] = nil
        if error == nil {
            DispatchQueue.main.async {
                ch?(receivedData)
            }
        }
    }

}
