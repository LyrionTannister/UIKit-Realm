//
//  Photo.swift
//  notVK
//
//  Created by Roman on 18.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

struct PhotoResponse: Decodable {
    var response: PhotoList
}

struct PhotoList: Decodable {
    var items: [PhotoItems]
}

struct PhotoItems: Decodable {
    var sizes: [Sizes]
}

struct Sizes: Decodable {
    var url: String?
}
