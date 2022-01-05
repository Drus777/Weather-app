//
//  DailyWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

final class DailyWeatherTableCellModel: CellModels {
    
    var dailyWeather: [DailyWeather]
    
    init(dailyWeather: [DailyWeather]) {
        self.dailyWeather = dailyWeather
    }
}
