//
//  NewsAttachment.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsAttachment: Decodable {
    
    var type: String? = ""
    var photo: PhotoItems?
    var link: NewsLink?
    var video: NewsVideo?
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case photo
        case link
        case video
        
    }

    required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try? container.decodeIfPresent(String.self, forKey: .type)
        photo = try? container.decodeIfPresent(PhotoItems.self, forKey: .photo)
        link = try? container.decodeIfPresent(NewsLink.self, forKey: .link)
        video = try? container.decodeIfPresent(NewsVideo.self, forKey: .video)
        
    }
    
}
