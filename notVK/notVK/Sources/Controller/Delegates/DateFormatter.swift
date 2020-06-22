//
//  DateFormatter.swift
//  notVK
//
//  Created by Roman on 22.06.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import Foundation

extension DateFormatter {
    func convertDate(timeIntervalSince1970: Double) -> String{
        dateFormat = "MM-dd-yyyy HH.mm"
        timeZone = TimeZone(abbreviation: "UTC")
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return string(from: date)
    }
}
