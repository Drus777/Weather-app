//
//  MainWeatherModel.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation

protocol MainTableModel: AnyObject, Models {
    var cellModelsDidChange: (() -> Void)? { get  }
    
    func loadData()
}

final class MainWeatherModel: MainTableModel {
    
    private let networkController = NetworkController()
    private let locationService = LocationService()
    
    lazy var mainTableDataSource = MainTableDataSource(hourlyWeatherDataSource: hourlyWeatherCollectionDataSource, detailWeatherDataSource: detailWeatherCollectionDataSource)
    private var hourlyWeatherCollectionDataSource = HourlyWeatherCollectionDataSource()
    private var detailWeatherCollectionDataSource = DetailWeatherCollectionDataSource()
    
    private var cellModels: [CellModelNames: CellModels] = [:] {
        didSet {
            mainTableDataSource.cellModels = cellModels
            hourlyWeatherCollectionDataSource.cellModels = cellModels
            detailWeatherCollectionDataSource.cellModels = cellModels
            cellModelsDidChange?()
        }
    }
    
    var cellModelsDidChange: (() -> Void)?
    
    func loadData() {
        
        networkController.fetchWeatherData(lat: "\(locationService.lat)", lon: "\(locationService.lon)", units: .metric, lang: .russian) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                if let model = weather {
                    self.setCellModels(model)
                }
            case .failure(let error):
                print("\(#function) error handled: \(error.localizedDescription)")
            }
        }
    }
    
    private func setCellModels(_ model: WeatherResponceModel) {
        
        guard
            let cityName = model.timezone,
            let currentTemp = model.current.temp,
            let description = model.current.weather.first?.description,
            let dailyTemp = model.daily[0].temp,
            let maxTemp = dailyTemp.max,
            let minTemp = dailyTemp.min
        else { return }
        
        cellModels[.currentWeatherCellModel] = CurrentWeatherCellModel(
            cityName: cityName,
            currentTemp: currentTemp,
            description: description,
            minTemp: minTemp,
            maxTemp: maxTemp
        )
        cellModels[.hourlyWeatherTableCellModel] = HourlyWeatherTableCellModel(info: description)
        cellModels[.hourlyWeatherCollectionCellModel] = HourlyWeatherCollectionCellModel(by: model)
        cellModels[.dailyWeatherTableCellModel] = DailyWeatherTableCellModel(by: model.daily)
        cellModels[.detailWeatherCollectionCellModel] = DetailWeatherCollectionCellModel(model: model)
    }
}

