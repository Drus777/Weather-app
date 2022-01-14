//
//  HourlyWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 3.01.22.
//

import Foundation

struct HourlyWeatherDataModel: CellModels {
    var time: String
    var temp: String
    var icon: String
    var precipitation: Double
    var sunrise: String
    var sunset: String
}

final class HourlyWeatherCollectionCellModel: CellModels {
    
    var dataModel: [HourlyWeatherDataModel] = []
    
    init(by model: WeatherResponceModel) {
        fillDataModel(by: model)
    }
    
    private func fillDataModel(by model: WeatherResponceModel) {
        
        for (index, element) in model.hourly.enumerated() {
            
            if  let time = element.dt,
                let temp = element.temp,
                let icon = element.weather[0].icon,
                let pop = element.pop,
                let sunrise = model.daily[0].sunrise,
                let sunset = model.daily[0].sunset {
                
                let sunriseHourMinute = Date.dateConvertion(unixTime: Double(sunrise), dateFormat: "HH:mm")
                let sunsetHourMinute = Date.dateConvertion(unixTime: Double(sunset), dateFormat: "HH:mm")
                
                let timeHour = Date.dateConvertion(unixTime: Double(time), dateFormat: "HH")
                let sunriseHour = Date.dateConvertion(unixTime: Double(sunrise), dateFormat: "HH")
                let sunsetHour = Date.dateConvertion(unixTime: Double(sunset), dateFormat: "HH")
                
                if index == 0 {
                    dataModel.append(
                        .init(time: "Сейчас", temp: "\(Int(temp))°", icon: icon, precipitation: pop, sunrise: sunriseHourMinute, sunset: sunsetHourMinute)
                    )
                } else if timeHour == sunriseHour {
                    dataModel.append(
                        .init(time: sunriseHourMinute, temp: "Восход солнца", icon: "sunrise.fill", precipitation: 0, sunrise: sunriseHourMinute, sunset: sunsetHourMinute)
                    )
                } else if timeHour == sunsetHour {
                    dataModel.append(
                        .init(time: sunsetHourMinute, temp: "Заход солнца", icon: "sunset.fill", precipitation: 0, sunrise: sunriseHourMinute, sunset: sunsetHourMinute)
                    )
                } else {
                    dataModel.append(
                        .init(time: timeHour, temp: "\(Int(temp))°", icon: icon, precipitation: pop, sunrise: sunriseHourMinute, sunset: sunsetHourMinute)
                    )
                }
            }
        }
    }
}
