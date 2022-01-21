//
//  MapCellModel.swift
//  WeatherApp
//
//  Created by Алексей Авдейчик on 21.01.22.
//

import Foundation

class MapCellModel: CellModel {
    
    let currentTemp: Double
    
    init(currentTemp: Double) {
        self.currentTemp = currentTemp
        
        super.init(cellIdentifier: MapTableCell.identifier)
    }
}

