//
//  VKDataSelector.swift
//  notVK
//
//  Created by Roman on 14.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class VKDataSelector {
    
    private init() {}
    
    public static let shared = VKDataSelector()
    
    let baseUrl = "https://api.vk.com/method/"
//    var baseParameters: String {
//        return "?access_token=\(Session.shared.token)&extended=1&v=5.103"
//    }
    
    enum Method {
        case getGroups
        case getFriends
        case getPhotos
        case searchGroups
        
        var methodName: String {
            switch self {
            case .getGroups:
                return "groups.get"
            case .getFriends:
                return "friends.get"
            case .getPhotos:
                return "photos.get"
            case .searchGroups:
                return "groups.search"
            }
        }
    }
}
