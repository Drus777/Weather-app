//
//  BaseModel.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation

protocol DetailWeatherModel: AnyObject {
    var detailWeatherCollectionDataSource: DetailWeatherCollectionDataSource { get }
}

protocol HourlyWeatherModel: AnyObject {
    var hourlyWeatherCollectionDataSource: HourlyWeatherCollectionDataSource { get }
}

protocol MainTableModel: AnyObject {
    var mainTableDataSource: MainTableDataSource { get }
    var cellModelsDidChange: (() -> Void)? { get set }
    
    func loadData()
}

final class BaseModel: MainTableModel, HourlyWeatherModel, DetailWeatherModel {
    
    private let networkController = NetworkController()
    private let locationService = LocationService.shared
    
    lazy var mainTableDataSource = MainTableDataSource(self, detailWeatherModel: self)
    lazy var hourlyWeatherCollectionDataSource = HourlyWeatherCollectionDataSource()
    lazy var detailWeatherCollectionDataSource = DetailWeatherCollectionDataSource()
    
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
        networkController.fetchWeatherData { [weak self] result in
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
    
    private func setCellModels(_ model: WeatherModel) {
        
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
            minTemp: maxTemp,
            maxTemp: minTemp
        )
        cellModels[.hourlyWeatherTableCellModel] = HourlyWeatherTableCellModel(info: description)
        cellModels[.hourlyWeatherCollectionCellModel] = HourlyWeatherCollectionCellModel(hourlyWeather: model.hourly)
        cellModels[.dailyWeatherTableCellModel] = DailyWeatherTableCellModel(dailyWeather: model.daily)
        cellModels[.detailWeatherCollectionCellModel] = DetailWeatherCollectionCellModel()
    }
}

