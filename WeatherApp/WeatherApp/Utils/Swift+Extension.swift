//
//  Swift+Extension.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation

extension String {
    func toDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: self) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            dayFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dayFormatter.string(from: date)
        }
        
        return ""
    }
}
