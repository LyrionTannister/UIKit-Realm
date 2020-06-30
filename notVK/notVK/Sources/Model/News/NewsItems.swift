//
//  News.swift
//  notVK
//
//  Created by Roman on 22.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class NewsItems: Decodable {
    var items: [NewsItem]
    var profiles: [FriendItem]
    var groups: [GroupItem]
    var nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }

    init(items: [NewsItem], profiles: [FriendItem], groups: [GroupItem], nextFrom: String) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
}
