//
//  NewsItem.swift
//  notVK
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class NewsItem: Decodable {
    
    var type : String = ""
    var sourceID = 0
    var date: Int = 0
    var postType : String? = ""
    var text : String? = ""
    var attachments : [NewsAttachment]? = []
    var photos : PhotoList?
    var comments : NewsComments?
    var likesNews : NewsLikesNews?
    var repostsNews : NewsRepostsNews?
    var views : NewsViews?
    var isFavorite : Bool = false
    var postID : Int = 0
    
    required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postID = try container.decode(Int.self, forKey: .postID)
        sourceID = try container.decode(Int.self, forKey: .sourceID)
        date = try container.decode(Int.self, forKey: .date)
        type = try container.decode(String.self, forKey: .type)
        
        likesNews = try? container.decodeIfPresent(
            NewsLikesNews.self,
            forKey: .likesNews
        
        )
        comments = try? container.decodeIfPresent(
            NewsComments.self,
            forKey: .comments
        )
        
        repostsNews = try? container.decodeIfPresent(
            NewsRepostsNews.self,
            forKey: .repostsNews
        )
        
        views = try? container.decodeIfPresent(NewsViews.self, forKey: .views)
        postType = try? container.decodeIfPresent(String.self, forKey: .postType)
        text = try? container.decodeIfPresent(String.self, forKey: .text)
        photos = try? container.decodeIfPresent(PhotoList.self, forKey: .photos)
        
        attachments = try? container.decodeIfPresent(
            [NewsAttachment].self,
            forKey: .attachments
        )
        
    }


    enum CodingKeys: String, CodingKey {
        
        case type
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
        case photos
        case comments
        case likesNews = "likes"
        case repostsNews = "reposts"
        case views
        case isFavorite = "is_favorite"
        case postID = "post_id"
        
    }
    
    func getLikesInfo() -> (Int,Bool) {
        
        guard let likes = likesNews else {
            return (0,false)
        }
        return (likes.count, likes.userLikes>0)
        
    }
    
}
