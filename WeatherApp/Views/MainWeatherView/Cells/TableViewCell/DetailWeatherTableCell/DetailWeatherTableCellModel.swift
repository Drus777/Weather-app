//
//  DetailWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 18.01.22.
//

import Foundation

final class DetailWeatherTableCellModel: CellModel {
    
    var dataSource: WeatherCollectionDataSource
    
    init(dataSource: WeatherCollectionDataSource) {
        self.dataSource = dataSource
        super.init(cellIdentifier: DetailWeatherTableCell.identifier)
    }
}

