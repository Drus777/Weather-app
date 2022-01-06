//
//  HourlyWeatherCollectionDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import UIKit

final class HourlyWeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var cellModels: [CellModelNames : CellModels]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard
            let cellModels = cellModels,
            let cellModel = cellModels[.hourlyWeatherCollectionCellModel] as? HourlyWeatherCollectionCellModel
        else { return 0 }
        return cellModel.hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.identifier, for: indexPath) as? HourlyWeatherCollectionCell
        else { return .init() }
        
        guard
            let cellModels = cellModels,
            let cellModel = cellModels[.hourlyWeatherCollectionCellModel]
        else { return cell }
        
        cell.fill(by: cellModel, index: indexPath.item)
        return cell
    }
}
