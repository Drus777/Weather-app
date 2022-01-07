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
        
        let sunsetDate = Date(timeIntervalSince1970: Double(sunset))
        let sunriseDate = Date(timeIntervalSince1970: Double(sunrise))
        let currentDate = Date().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let sunsetString = dateFormatter.string(from: sunsetDate)
        let sunriseString = dateFormatter.string(from: sunriseDate)
        
        let uvIndexModel = DetailDataModel(
            icon: UIImage(systemName: "sun.min.fill")!,
            title: "УФ-ИНДЕКС",
            data: uvi <= 2 ? "\(Int(uvi))\nНизкий" : "\(Int(uvi))\nВысокий",
            info: uvi <= 2 ? "Индекс останется низким до конца дня" : "Индекс останется высоким до конца дня"
        )
        let sunsetModel = DetailDataModel(
            icon: Int(currentDate) < sunrise ? UIImage(systemName: "sunrise.fill")! : UIImage(systemName: "sunset.fill")!,
            title: Int(currentDate) < sunrise ? "ЗАХОД СОЛНЦА" : "ВОСХОД СОЛНЦА",
            data: Int(currentDate) < sunrise ? "\(sunsetString)" : "\(sunriseString)",
            info: Int(currentDate) < sunrise ? "Восход: \(sunriseString)" : "Закат: \(sunsetString)"
        )
        let windModel = DetailDataModel(
            icon: UIImage(systemName: "wind")!,
            title: "ВЕТЕР",
            data: "\(Int(windSpeed)) км/ч"
        )
        let precipitationModel = DetailDataModel(
            icon: UIImage(systemName: "cloud.snow.fill")!,
            title: "ОСАДКИ",
            data: "\(model.daily[0].snow ?? 0) мм\nза сутки"
        )
        let fillsLikeModel = DetailDataModel(
            icon: UIImage(systemName: "thermometer")!,
            title: "ОЩУЩАЕТСЯ КАК",
            data: "\(Int(feelsLike))°",
            info: "По ощущениям холоднее из-за ветра"
        )
        let humidityModel = DetailDataModel(
            icon: UIImage(systemName: "humidity")!,
            title: "ВЛАЖНОСТЬ",
            data: "\(humidity)%",
            info: "Точка росы\nсейчас: \(dewPoint)°"
        )
        let visabilityModel = DetailDataModel(
            icon: UIImage(systemName: "eye.fill")!,
            title: "ВИДИМОСТЬ",
            data: "\(visability / 1000) км"
        )
        let pressureModel = DetailDataModel(
            icon: UIImage(systemName: "gauge")!,
            title: "ДАВЛЕНИЕ",
            data: "\(pressure)\nгПа"
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
