//
//  DetailWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import Foundation

class DetailDataModel: CellModels {
    var icon: String
    var title: String
    var data: String
    var info: String?
    
    init(icon: String, title: String, data: String, info: String?) {
        self.icon = icon
        self.title = title
        self.data = data
        self.info = info
    }
}

class DetailWeatherCollectionCellModel: CellModels {
    
    var dataModel: [DetailDataModel]
    
    init(dataModel: [DetailDataModel]) {
        self.dataModel = dataModel
    }
}
