//
//  RepostsNews.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class RepostsNews: Decodable {
    var count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(count: Int, userReposted: Int) {
        self.count = count
        self.userReposted = userReposted
    }
}
