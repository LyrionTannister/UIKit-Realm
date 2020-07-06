//
//  GroupItem.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

class GroupItem: Object, Decodable {
    
    @objc dynamic var photo50: String? = ""
    @objc dynamic var name: String = ""
    enum CodingKeys: String, CodingKey {
        case photo50 = "photo_50"
        case name = "name"
    }
    
}
