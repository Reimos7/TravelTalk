//
//  DateFormatter+Extension.swift
//  TravelTalk
//
//  Created by Reimos on 7/20/25.
//

import Foundation

extension Date {
    func chatDateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h시 mm분 a"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
}
