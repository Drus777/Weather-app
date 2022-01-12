//
//  File.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import UIKit

final class DetailWeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var cellModels: [CellModelNames : CellModels]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard
            let cellModels = cellModels,
            let cellModel = cellModels[.detailWeatherCollectionCellModel] as? DetailWeatherCollectionCellModel
        else { return 0 }
        return cellModel.dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherCollectionCell.identifier, for: indexPath) as? DetailWeatherCollectionCell
        else { return .init() }
        
        guard
            let cellModels = cellModels,
            let cellModel = cellModels[.detailWeatherCollectionCellModel] as? DetailWeatherCollectionCellModel
        else { return cell }
        
        cell.fill(by: cellModel.dataModel[indexPath.item])
        return cell
    }
}
