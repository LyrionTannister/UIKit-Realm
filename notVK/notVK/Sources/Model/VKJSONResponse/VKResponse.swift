//
//  VKResponse.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

class VKResponse<T: Codable>: Codable {
 
    let response: VKItems<T>

}
