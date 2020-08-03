//
//  SaveDataOperation.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

class SaveDataOperation<T: Object & Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
            let outputData = parseDataOperation.outputData else { return }
       
        //RealmRequestService.shared.deleteObjects(T.self)
        //RealmRequestService.shared.commitObjects(outputData)
        do {
            let realm = try Realm()
            let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
            print("Completed Saving")
        } catch {
            print(error)
        }
        //print("Completed Saving")
        
    }
    
}
