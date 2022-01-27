//
//  WeatherCollectionDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import UIKit

final class WeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var cellModels: [CellModel] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard cellModels.count > indexPath.item else { return .init() }
        let cellModel = cellModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier, for: indexPath)
        if let fillableCell = cell as? FillableCell {
            fillableCell.fill(by: cellModel)
        }
        return cell
    }
}
