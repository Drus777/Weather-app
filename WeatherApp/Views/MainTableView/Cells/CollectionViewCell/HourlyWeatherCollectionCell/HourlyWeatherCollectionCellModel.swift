//
//  HourlyWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 3.01.22.
//

import Foundation

final class HourlyWeatherCollectionCellModel: CellModels {
    
    var hourlyWeather: [HourlyWeather]
    
    init(hourlyWeather: [HourlyWeather]) {
        self.hourlyWeather = hourlyWeather
    }
}
