//
//  GetDataRequest.swift
//  notVK
//
//  Created by Roman on 16.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class GetDataRequest: NSObject {
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
    // ...
    deinit {
        self.session.invalidateAndCancel()
    }
}
