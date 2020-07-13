//
//  PhotoItems.swift
//  notVK
//
//  Created by Roman on 18.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoItems: Object, Decodable {
    @objc dynamic var photoId: Int
    @objc dynamic var url: String

    override var description: String {
        return String(format: "%ld (%@)", photoId, url)
    }
}

extension PhotoItems {
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case url = "photo_604"
    }
}
