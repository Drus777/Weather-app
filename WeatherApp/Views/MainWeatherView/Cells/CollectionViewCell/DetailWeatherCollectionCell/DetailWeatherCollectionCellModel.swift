//
//  DetailWeatherCollectionCellModel.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import Foundation

final class DetailCellDataModel: CellModel {
    var icon: String
    var title: String
    var data: String
    var info: String
    
    init(icon: String, title: String, data: String, info: String) {
        self.icon = icon
        self.title = title
        self.data = data
        self.info = info
        super.init(cellIdentifier: DetailWeatherCollectionCell.identifier)
    }
}

final class DetailWeatherCollectionCellModel: CellModel {
    
    var dataModel: [DetailCellDataModel] = []
    
    init(by model: WeatherResponseModel) {
        super.init(cellIdentifier: DetailWeatherCollectionCell.identifier)
        self.fillDataModel(by: model)
    }
    
    private func fillDataModel(by model: WeatherResponseModel) {
        var dataModel: [DetailCellDataModel] = []
        
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
        else { return }
        
        let currentDate = Date().timeIntervalSince1970
        let sunsetString = Date.dateConvertion(unixTime: Double(sunset), dateFormat: "HH:mm")
        let sunriseString = Date.dateConvertion(unixTime: Double(sunrise), dateFormat: "HH:mm")
        
        let uvIndexModel = DetailCellDataModel(
            icon: "sun.min.fill",
            title: "УФ-ИНДЕКС",
            data: uvi <= 2 ? "\(Int(uvi))\nНизкий" : "\(Int(uvi))\nВысокий",
            info: uvi <= 2 ? "Индекс останется низким до конца дня" : "Индекс останется высоким до конца дня"
        )
        let sunsetModel = DetailCellDataModel(
            icon: Int(currentDate) < sunrise ? "sunrise.fill" : "sunset.fill",
            title: Int(currentDate) < sunrise ? "ВОСХОД СОЛНЦА" : "ЗАХОД СОЛНЦА",
            data: Int(currentDate) < sunrise ? "\(sunriseString)" : "\(sunsetString)",
            info: Int(currentDate) < sunrise ? "Закат: \(sunsetString)" : "Восход: \(sunriseString)"
        )
        let windModel = DetailCellDataModel(
            icon: "wind",
            title: "ВЕТЕР",
            data: "\(Int(windSpeed)) км/ч",
            info: "Сильный ветер в течении дня"
        )
        let precipitationModel = DetailCellDataModel(
            icon: "cloud.snow.fill",
            title: "ОСАДКИ",
            data: "\(Int(model.daily[0].snow ?? 0)) мм\nза сутки",
            info: Int(model.daily[0].snow ?? 0) == 0 ? "Без осадков" : "Осадки будут идти весь день"
        )
        let fillsLikeModel = DetailCellDataModel(
            icon: "thermometer",
            title: "ОЩУЩАЕТСЯ КАК",
            data: "\(Int(feelsLike))°",
            info: "По ощущениям холоднее из-за ветра"
        )
        let humidityModel = DetailCellDataModel(
            icon: "humidity",
            title: "ВЛАЖНОСТЬ",
            data: "\(humidity)%",
            info: "Точка росы\nсейчас: \(dewPoint)°"
        )
        let visabilityModel = DetailCellDataModel(
            icon: "eye.fill",
            title: "ВИДИМОСТЬ",
            data: "\(visability / 1000) км",
            info: "Плохая видимость до конца дня"
        )
        let pressureModel = DetailCellDataModel(
            icon: "gauge",
            title: "ДАВЛЕНИЕ",
            data: "\(pressure)\nгПа",
            info: "Давление не измениться в течении дня"
        )
        
        dataModel.append(uvIndexModel)
        dataModel.append(sunsetModel)
        dataModel.append(windModel)
        dataModel.append(precipitationModel)
        dataModel.append(fillsLikeModel)
        dataModel.append(humidityModel)
        dataModel.append(visabilityModel)
        dataModel.append(pressureModel)
        
        self.dataModel = dataModel
    }
}
