//
//  Photo.swift
//  notVK
//
//  Created by Roman on 18.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

struct PhotoResponse: Decodable {
    var response: PhotoList
}

struct PhotoList: Decodable {
    var items: [PhotoItems]
}

class PhotoItems: Object, Decodable {
    @objc dynamic var photoId: Int
    @objc dynamic var url: String

    override var description: String {
        return String(format: "%ld (%@)", photoId, url)
    }
}

class Sizes: Object, Decodable {
    @objc dynamic var url: String? = ""
}

extension PhotoItems {
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case url = "photo_604"
    }
}
