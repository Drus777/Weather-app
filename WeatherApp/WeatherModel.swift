//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation

struct Weather: Codable {
    var icon: String?
    var description: String?
}

struct Temperature: Codable {
    var min: Double?
    var max: Double?
}

struct CurrentWeather: Codable {
    var temp: Double?
    var weather: [Weather]
    var pressure: Int?
    var humidity: Int?
    var uvi: Double?
    var visibility: Int?
    var windSpeed: Double?
    var feelsLike: Double?
    var windDeg: Int?
    var dewPoint: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case weather
        case pressure
        case humidity
        case uvi
        case visibility
        case windSpeed = "wind_speed"
        case feelsLike = "feels_like"
        case windDeg = "wind_deg"
        case dewPoint = "dew_point"
    }
}

struct HourlyWeather: Codable {
    var dt: Int?
    var temp: Double?
    var weather: [Weather]
    var pop: Double?
}

struct DailyWeather: Codable {
    var dt: Int?
    var temp: Temperature?
    var weather: [Weather]
    var pop: Double?
    var rain: Double?
    var snow: Double?
    var sunrise: Int?
    var sunset: Int?
}

struct WeatherModel: Codable {
    var timezone: String?
    var current: CurrentWeather
    var hourly: [HourlyWeather]
    var daily: [DailyWeather]
}

