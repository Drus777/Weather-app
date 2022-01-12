//
//  Date+Utils.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import Foundation

extension Date {
   static func dateConvertion(unixTime: Double, dateFormat: String) -> String {
        let time = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: time)
    }
}
