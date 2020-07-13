//
//  Session.swift
//  notVK
//
//  Created by Roman on 14.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token = String()
    var userId = Int()
    
}
