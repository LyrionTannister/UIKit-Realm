//
//  ParseDataOperation.swift
//  notVK
//
//  Created by Roman on 24.07.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class ParseDataOperation<T:Codable>: Operation {
    
    var outputData: [T]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else { return }
        
        guard let dataParsed = try? JSONDecoder()
            .decode(VKResponse<T>.self, from: data).response.items else {
                print("FAILED TO DECODE JSON")
                return
        }
        outputData = dataParsed
    }
    
}
