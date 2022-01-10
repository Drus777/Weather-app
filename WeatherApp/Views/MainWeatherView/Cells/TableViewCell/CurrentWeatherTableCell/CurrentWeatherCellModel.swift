//
//  CurrentWeatherCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 3.01.22.
//

import Foundation

final class CurrentWeatherCellModel: CellModels {
    
    var cityName: String
    var currentTemp: Double
    var description: String
    var minTemp: Double
    var maxTemp: Double
    
    init(cityName: String, currentTemp: Double, description: String, minTemp: Double, maxTemp: Double) {
        self.cityName = cityName
        self.currentTemp = currentTemp
        self.description = description
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
}
