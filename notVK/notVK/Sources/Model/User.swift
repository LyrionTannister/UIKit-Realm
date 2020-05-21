//
//  User.swift
//  notVK
//
//  Created by Roman on 02.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

struct User {
    enum Sex: CustomStringConvertible {
        case male
        case female
        var description: String
        {
            switch self {
            case .male:
                return "Мужчина"
            case .female:
                return "Женщина"
            }
        }
    }

    var firstName: String
    var lastName: String
    var age: Int
    var city: String
    var sex: Sex
    var fotoPath: String
    var photos: [String]
    var onLineState: Bool
    
    init(sex: Sex, firstName: String,
         lastName: String, age: Int,
         city: String, fotoPath: String, photos: [String],
         onLineState: Bool) {
        self.sex = sex
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.city = city
        self.fotoPath = fotoPath
        self.photos = photos
        self.onLineState = onLineState
    }
}
