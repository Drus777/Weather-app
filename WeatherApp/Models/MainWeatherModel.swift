//
//  MainWeatherModel.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation

protocol UpdatableModel: AnyObject, Model {
    var weatherTableCellModelsDidChange: (() -> Void)? { get set }
    
    func loadData()
}

final class MainWeatherModel: UpdatableModel {
    
    private let networkController: LoadableNetwork
    
    var weatherTableDataSource = WeatherTableDataSource()
    var hourlyWeatherCollectionDataSource = WeatherCollectionDataSource()
    var detailWeatherCollectionDataSource = WeatherCollectionDataSource()
    
    private var weatherTableCellModels: [CellModel] = [] {
        didSet {
            weatherTableDataSource.cellModels = weatherTableCellModels
            weatherTableCellModelsDidChange?()
        }
    }
    
    private var hourlyWeatherCollectionCellModels: [CellModel] = [] {
        didSet {
            hourlyWeatherCollectionDataSource.cellModels = hourlyWeatherCollectionCellModels
        }
    }
    
    private var detailWeatherCollectionCellModels: [CellModel] = [] {
        didSet {
            detailWeatherCollectionDataSource.cellModels = detailWeatherCollectionCellModels
        }
    }
    
    var weatherTableCellModelsDidChange: (() -> Void)?
    
    init(networkController: LoadableNetwork) {
        self.networkController = networkController
    }
    
    func loadData() {
        //проверять текущую локализацию и ставить ее дефолтной(как хост)
        networkController.fetchWeatherData(lat: "\(LocationService.shared.coordinate?.latitude ?? 0)", lon: "\(LocationService.shared.coordinate?.longitude ?? 0)") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherResponse):
                self.setCellModels(weatherResponse)
            case .failure(let error):
                print("\(#function) error handled: \(error.localizedDescription)")
            }
        }
    }
    
    private func setCellModels(_ model: WeatherResponseModel?) {
        
        guard let model = model,
              let cityName = model.timezone,
              let currentTemp = model.current.temp,
              let description = model.current.weather.first?.description,
              let dailyTemp = model.daily[0].temp,
              let maxTemp = dailyTemp.max,
              let minTemp = dailyTemp.min
        else { return }
        
        weatherTableCellModels.append(
            CurrentWeatherCellModel(
                cityName: cityName,
                currentTemp: currentTemp,
                description: description,
                minTemp: minTemp,
                maxTemp: maxTemp
            )
        )
        hourlyWeatherCollectionCellModels = HourlyWeatherCollectionCellModel(by: model).dataModel
        weatherTableCellModels.append(HourlyWeatherTableCellModel(info: description, dataSource: hourlyWeatherCollectionDataSource, collectionCellModel: hourlyWeatherCollectionCellModels))
        weatherTableCellModels.append(DailyWeatherTableCellModel(by: model.daily))
        weatherTableCellModels.append(MapCellModel(currentTemp: currentTemp))
        weatherTableCellModels.append(DetailWeatherTableCellModel(dataSource: detailWeatherCollectionDataSource))
        detailWeatherCollectionCellModels = DetailWeatherCollectionCellModel(by: model).dataModel
    }
}

