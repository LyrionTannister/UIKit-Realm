//
//  Photo.swift
//  notVK
//
//  Created by Roman on 18.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoResponse: Object, Decodable {
    @objc dynamic var response: PhotoList
}

class PhotoList: Object, Decodable {
    @objc dynamic var items: [PhotoItems]
}

class PhotoItems: Object, Decodable {
    @objc dynamic var sizes: [Sizes]
}

class Sizes: Object, Decodable {
    @objc dynamic var url: String?
}
