//
//  CurrentWeatherDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class WeatherTableDataSource: NSObject, UITableViewDataSource {
    
    var cellModels: [CellModel] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let cellModel = cellModels[section] as? DailyWeatherTableCellModel {
            return cellModel.dataModel.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard cellModels.count > indexPath.section else { return .init() }
        if let cellModel = cellModels[indexPath.section] as? DailyWeatherTableCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
            
            if indexPath.row == (cellModel.dataModel.count - 1) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
            
            if let fillableCell = cell as? FillableCell {
                fillableCell.fill(by: cellModel.dataModel[indexPath.row])
            }
            return cell
        } else {
            let cellModel = cellModels[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
            if let fillableCell = cell as? FillableCell {
                fillableCell.fill(by: cellModel)
            }
            return cell
        }
    }
}
