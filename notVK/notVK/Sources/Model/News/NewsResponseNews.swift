//
//  NewsResponseNews.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsResponseNews: Decodable {
    
    var response: NewsItems
    
    init(response: NewsItems) {
        self.response = response
    }
    
}
