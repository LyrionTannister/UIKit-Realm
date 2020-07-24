//
//  RealmOperations.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class RealmOperations {
    
    static let shared = RealmOperations()
    private let queue = OperationQueue()
    
    private init() {}
    
    //MARK: Friends Operation Chain
    func fetchFriendsFromRealm(){
        let urlRequest = URLStorage.shared.getURLDataCommunites()
        
        let getDataOperation = GetDataOperation(urlRequest: urlRequest!)
        queue.addOperation(getDataOperation)
        
        let parseDataOperation = ParseDataOperation<FriendItem>()
        parseDataOperation.addDependency(getDataOperation)
        queue.addOperation(parseDataOperation)
        
        let saveDataOperation = SaveDataOperation<FriendItem>()
        saveDataOperation.addDependency(parseDataOperation)
        queue.addOperation(saveDataOperation)
    }
    
}
