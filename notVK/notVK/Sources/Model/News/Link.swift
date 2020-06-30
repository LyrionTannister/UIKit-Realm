//
//  Link.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class Link: Decodable {
    var url: String = ""
    var title = ""
    var caption: String? = ""
    var photo : PhotoItems?

    enum CodingKeys: String, CodingKey {
        case url, title, caption, photo
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        caption = try? container.decodeIfPresent(String.self, forKey: .caption)
        photo = try? container.decodeIfPresent(PhotoItems.self, forKey: .photo)
    }
}
