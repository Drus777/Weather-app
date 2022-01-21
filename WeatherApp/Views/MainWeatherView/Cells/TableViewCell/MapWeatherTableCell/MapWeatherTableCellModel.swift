//
//  MapWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Алексей Авдейчик on 21.01.22.
//

import Foundation

class MapWeatherTableCellModel: CellModel {
    
    let currentTemp: Double
    let cityName: String
    
    init(currentTemp: Double, cityName: String) {
        self.currentTemp = currentTemp
        self.cityName = cityName
        
        super.init(cellIdentifier: MapWeatherTableCell.identifier)
    }
}
