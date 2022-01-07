//
//  DetailWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import Foundation
import UIKit

struct DetailDataModel {
    var icon: UIImage
    var title: String
    var data: String
    var info: String?
}

class DetailWeatherCollectionCellModel: CellModels {
    
    var dataModel: [DetailDataModel]
    
    init(dataModel: [DetailDataModel]) {
        self.dataModel = dataModel
    }
}
