//
//  friendFactory.swift
//  notVK
//
//  Created by Roman on 13.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

struct FriendResponse: Decodable {
    var response: FriendList
}

struct FriendList: Decodable {
    var count: Int
    var items: [FriendItem]
}

struct FriendItem: Object, Decodable {
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var online: Int
    @objc dynamic var photo100: String?
    @objc dynamic var id: Int
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case photo100 = "photo_100"
        case id
    }
}

