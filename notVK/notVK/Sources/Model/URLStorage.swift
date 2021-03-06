//
//  URLStorage.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class URLStorage {

    static let shared = URLStorage()
    private var urlConstructor = URLComponents()
    
    private init() {}
    
    func getURLForGroups() -> URLRequest? {
        
        urlConstructor.scheme = VKDataSelector.shared.scheme
        urlConstructor.host = VKDataSelector.shared.host
        urlConstructor.path = VKDataSelector.Method.getGroups.methodName
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: VKDataSelector.shared.apiVersion),
        ]
        return URLRequest(url: urlConstructor.url!)
    }
    
    func getURLforFriends() -> URLRequest? {
        
        urlConstructor.scheme = VKDataSelector.shared.scheme
        urlConstructor.host = VKDataSelector.shared.host
        urlConstructor.path = VKDataSelector.Method.getFriends.methodName
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: VKDataSelector.shared.apiVersion),
        ]
        return URLRequest(url: urlConstructor.url!)
    }
    
}
