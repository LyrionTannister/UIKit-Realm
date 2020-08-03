//
//  PromiseRealmService.swift
//  notVK
//
//  Created by Roman on 03.08.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

class PromiseRealmService<T: Object & Codable> {
    
    static var shared = PromiseRealmService()
    
    private init(){}
    
    func loadDataFromRealm() -> (T){
        
    }
}
