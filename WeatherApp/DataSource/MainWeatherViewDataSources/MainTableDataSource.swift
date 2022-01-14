//
//  CurrentWeatherDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class MainTableDataSource: NSObject, UITableViewDataSource {
    
    var cellModels: [CellModelNames : CellModels]?
    
    private var hourlyWeatherDataSource: HourlyWeatherCollectionDataSource
    private var detailWeatherDataSource: DetailWeatherCollectionDataSource
    
    init(hourlyWeatherDataSource: HourlyWeatherCollectionDataSource, detailWeatherDataSource: DetailWeatherCollectionDataSource) {
        self.hourlyWeatherDataSource = hourlyWeatherDataSource
        self.detailWeatherDataSource = detailWeatherDataSource
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.dailyWeatherTableCellModel] as? DailyWeatherTableCellModel
            else { return 0 }
            return cellModel.dataModel.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableCell.identifier, for: indexPath) as? CurrentWeatherTableCell
            else { return .init() }
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.currentWeatherCellModel]
            else { return cell }
            cell.fill(by: cellModel)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableCell.identifier, for: indexPath) as? HourlyWeatherTableCell
            else { return .init() }
            
            guard
                let cellModels = cellModels,
                let tableCellModel = cellModels[.hourlyWeatherTableCellModel],
                let collectionCellModel = cellModels[.hourlyWeatherCollectionCellModel] as? HourlyWeatherCollectionCellModel
            else { return cell }
            cell.cellModel = collectionCellModel
            cell.dataSource = hourlyWeatherDataSource
            cell.fill(by: tableCellModel)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableCell.identifier, for: indexPath) as? DailyWeatherTableCell
            else { return .init() }
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.dailyWeatherTableCellModel] as? DailyWeatherTableCellModel
            else { return cell }
            
            if indexPath.row == (cellModel.dataModel.count - 1) {
                cell.layer.cornerRadius = 15
                cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
            
            cell.fill(by: cellModel.dataModel[indexPath.row])
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailWeatherTableCell.identifier, for: indexPath) as? DetailWeatherTableCell
            else { return .init() }
            cell.dataSource = detailWeatherDataSource
            return cell
        default:
            break
        }
        
        return .init()
    }
}
