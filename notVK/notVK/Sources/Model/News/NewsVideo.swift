//
//  NewsVideo.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsVideo: Decodable {
    
    var accessKey: String = ""
    var canComment = 0
    var canLike = 0
    var canRepost = 0
    var canSubscribe = 0
    var canAddToFaves = 0
    var canAdd = 0
    var comments = 0
    var date = 0
    var videoDescription: String = ""
    var duration: Int = 0
    var image: [NewsFirstFrame] = []
    var firstFrame: [NewsFirstFrame] = []
    var width = 0
    var height = 0
    var id = 0
    var ownerID = 0
    var title = ""
    var trackCode = ""
    var type: String = ""
    var views: Int = 0

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case trackCode = "track_code"
        case type, views
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
    }
    
}
