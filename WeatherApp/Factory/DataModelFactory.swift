//
//  DataModelFactory.swift
//  WeatherApp
//
//  Created by Andrey on 7.01.22.
//

import Foundation
import UIKit

struct DataModelFactory {
    
    static func detailWeatherDataModel(_ model: WeatherModel) -> [DetailDataModel] {
        var dataModel: [DetailDataModel] = []
        
        guard
            let uvi = model.current.uvi,
            let sunset = model.daily[0].sunset,
            let sunrise = model.daily[0].sunrise,
            let windSpeed = model.current.windSpeed,
            let feelsLike = model.current.feelsLike,
            let humidity = model.current.humidity,
            let pressure = model.current.pressure,
            let visability = model.current.visibility,
            let dewPoint = model.current.dewPoint
        else { return [] }
        
        let currentDate = Date().timeIntervalSince1970
        let sunsetString = Date.dateConvertion(unixTime: Double(sunset), dateFormat: "HH:mm")
        let sunriseString = Date.dateConvertion(unixTime: Double(sunrise), dateFormat: "HH:mm")
        
        let uvIndexModel = DetailDataModel(
            icon: "sun.min.fill",
            title: "УФ-ИНДЕКС",
            data: uvi <= 2 ? "\(Int(uvi))\nНизкий" : "\(Int(uvi))\nВысокий",
            info: uvi <= 2 ? "Индекс останется низким до конца дня" : "Индекс останется высоким до конца дня"
        )
        let sunsetModel = DetailDataModel(
            icon: Int(currentDate) < sunrise ? "sunrise.fill" : "sunset.fill",
            title: Int(currentDate) < sunrise ? "ВОСХОД СОЛНЦА" : "ЗАХОД СОЛНЦА",
            data: Int(currentDate) < sunrise ? "\(sunriseString)" : "\(sunsetString)",
            info: Int(currentDate) < sunrise ? "Закат: \(sunsetString)" : "Восход: \(sunriseString)"
        )
        let windModel = DetailDataModel(
            icon: "wind",
            title: "ВЕТЕР",
            data: "\(Int(windSpeed)) км/ч",
            info: nil
        )
        let precipitationModel = DetailDataModel(
            icon: "cloud.snow.fill",
            title: "ОСАДКИ",
            data: "\(Int(model.daily[0].snow ?? 0)) мм\nза сутки",
            info: nil
        )
        let fillsLikeModel = DetailDataModel(
            icon: "thermometer",
            title: "ОЩУЩАЕТСЯ КАК",
            data: "\(Int(feelsLike))°",
            info: "По ощущениям холоднее из-за ветра"
        )
        let humidityModel = DetailDataModel(
            icon: "humidity",
            title: "ВЛАЖНОСТЬ",
            data: "\(humidity)%",
            info: "Точка росы\nсейчас: \(dewPoint)°"
        )
        let visabilityModel = DetailDataModel(
            icon: "eye.fill",
            title: "ВИДИМОСТЬ",
            data: "\(visability / 1000) км",
            info: nil
        )
        let pressureModel = DetailDataModel(
            icon: "gauge",
            title: "ДАВЛЕНИЕ",
            data: "\(pressure)\nгПа",
            info: nil
        )
        
        dataModel.append(uvIndexModel)
        dataModel.append(sunsetModel)
        dataModel.append(windModel)
        dataModel.append(precipitationModel)
        dataModel.append(fillsLikeModel)
        dataModel.append(humidityModel)
        dataModel.append(visabilityModel)
        dataModel.append(pressureModel)
        
        return dataModel
    }
}
