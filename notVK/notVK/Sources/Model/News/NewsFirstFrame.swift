//
//  NewsFirstFrame.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsFirstFrame: Decodable {
    
    var height: Int
    var url: String
    var width: Int
    var withPadding: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, url, width
        case withPadding = "with_padding"
    }

    init(height: Int, url: String, width: Int, withPadding: Int?) {
        
        self.height = height
        self.url = url
        self.width = width
        self.withPadding = withPadding
        
    }
    
}
