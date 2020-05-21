//
//  GroupsFactory.swift
//  notVK
//
//  Created by Roman on 19.04.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class  GroupFactory  {
    static func makeGroups () -> [Group] {
        return [
            Group(name: "iOS", count: 1024, groupType: Group.GroupType.openGroup, fotoPath: "iconiOS"),
            Group(name: "GeekBrains", count: 543, groupType: Group.GroupType.openGroup, fotoPath: "iconGeekBrains"),
            Group(name: "Apple", count: 335654, groupType: Group.GroupType.openGroup, fotoPath: "iconApple"),
            Group(name: "Сплат", count: 1234, groupType: Group.GroupType.openGroup, fotoPath: "iconSplat")
        ]
    }
}
