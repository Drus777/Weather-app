//
//  DailyWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

struct DailyWeatherCellDataModel: CellModels {
    var day: String
    var icon: String
    var minTemp: Double
    var maxTemp: Double
    var precipitation: Double
}

final class DailyWeatherTableCellModel: CellModels {
    
    var dataModel: [DailyWeatherCellDataModel] = []
    
    init(by model: [DailyWeather]) {
        fillDataModel(by: model)
    }
    
    private func fillDataModel(by model: [DailyWeather]) {
        
        let dateformater = DateFormatter()
        dateformater.dateFormat = "EE"
        dateformater.locale = Locale(identifier: "Ru-ru")
        
        for (index, element) in model.enumerated() {
            if let day = element.dt,
               let icon = element.weather[0].icon,
               let minTemp = element.temp?.min,
               let maxTemp = element.temp?.max,
               let pop = element.pop {
                if index == 0 {
                    dataModel.append(
                        .init(day: "Сегодня", icon: icon, minTemp: minTemp, maxTemp: maxTemp, precipitation: pop)
                    )
                } else {
                    let date = Date(timeIntervalSince1970: TimeInterval(day))
                    let dateString = dateformater.string(from: date)
                    dataModel.append(
                        .init(day: dateString, icon: icon, minTemp: minTemp, maxTemp: maxTemp, precipitation: pop)
                    )
                }
            }
        }
    }
}
