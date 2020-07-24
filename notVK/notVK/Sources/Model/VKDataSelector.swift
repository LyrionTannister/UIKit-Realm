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
    
    let scheme = "https"
    let host = "api.vk.com"
    let apiVersion = "5.103"
    
    enum Method {
        case getGroups
        case getFriends
        case getPhotos
        case searchGroups
        
        var methodName: String {
            switch self {
            case .getGroups:
                return "/method/groups.get"
            case .getFriends:
                return "/method/friends.get"
            case .getPhotos:
                return "/method/photos.get"
            case .searchGroups:
                return "/method/groups.search"
            }
        }
    }
    
}
