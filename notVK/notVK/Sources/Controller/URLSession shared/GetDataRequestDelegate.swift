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
    
    func appendHandler(_ ch: @escaping GetDataCH, task: URLSessionTask) {
        self.handlers[task.taskIdentifier] = ch
    }
    
    func urlSession(_ session: URLSession,
                    dataTask getDataTask: URLSessionDataTask,
                    didReceive data: Data) {
        guard let ch = self.handlers[getDataTask.taskIdentifier] else { return }
        ch(data)
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
