//
//  NewsViews.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsViews: Decodable {
    
    var count: Int

    init(count: Int) {
        self.count = count
    }
    
}
