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
}

struct HourlyWeather: Codable {
    var dt: Int?
    var temp: Double?
    var weather: [Weather]
}

struct DailyWeather: Codable {
    var dt: Int?
    var temp: Temperature?
    var weather: [Weather]
}

struct WeatherModel: Codable {
    var timezone: String?
    var current: CurrentWeather
    var hourly: [HourlyWeather]
    var daily: [DailyWeather]
}
