//
//  HourlyWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 3.01.22.
//

import Foundation

final class HourlyWeatherCollectionCellModel: CellModels {
    
    var weatherModel: WeatherModel
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
}
