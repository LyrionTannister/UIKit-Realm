//
//  FriendItem.swift
//  notVK
//
//  Created by Roman on 13.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit
import RealmSwift

class FriendItem: Object, Decodable {
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var photo100: String? = ""
    @objc dynamic var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case photo100 = "photo_100"
        case id
    }
    
}

