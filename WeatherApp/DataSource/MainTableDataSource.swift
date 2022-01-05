//
//  CurrentWeatherDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class MainTableDataSource: NSObject, UITableViewDataSource {
    
    var cellModels: [CellModelNames : CellModels]?
    
    private var model: HourlyWeatherModel?
    
    init(_ model: HourlyWeatherModel) {
        self.model = model
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.DailyWeatherTableCellModel] as? DailyWeatherTableCellModel
            else { return 0 }
            return cellModel.dailyWeather.count
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
                let cellModel = cellModels[.CurrentWeatherCellModel]
            else { return cell }
            cell.fill(by: cellModel)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableCell.identifier, for: indexPath) as? HourlyWeatherTableCell
            else { return .init() }
            cell.model = model
            
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.HourlyWeatherTableCellModel]
            else { return cell }
            cell.fill(by: cellModel)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableCell.identifier, for: indexPath) as? DailyWeatherTableCell
            else { return .init() }
            guard
                let cellModels = cellModels,
                let cellModel = cellModels[.DailyWeatherTableCellModel]
            else { return cell }
            cell.fill(by: cellModel, index: indexPath.row)
            return cell
            
        default:
            break
        }
        
        return .init()
    }
}
