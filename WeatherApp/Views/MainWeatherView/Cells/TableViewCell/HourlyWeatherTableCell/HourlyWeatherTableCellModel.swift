//
//  HourlyWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

final class HourlyWeatherTableCellModel: CellModel {
    
    var info: String
    var dataSource: WeatherCollectionDataSource
    var collectionCellModel: [CellModel]
    
    init(info: String, dataSource: WeatherCollectionDataSource, collectionCellModel: [CellModel]) {
        self.info = info
        self.dataSource = dataSource
        self.collectionCellModel = collectionCellModel
        super.init(cellIdentifier: HourlyWeatherTableCell.identifier)
    }
}
