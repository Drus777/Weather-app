//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation
import CoreLocation

class NetworkController {
    
    private let locationService = LocationService.shared

    private let host = "https://api.openweathermap.org/"
    private let apiService = APIService()
    
    func fetchWeatherData(completion: @escaping (Result<WeatherModel?, Error>) -> Void) {
        
        let lat = "\(locationService.lat)"
        let lon = "\(locationService.lon)"
        
        let parameters = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
        ]
        
        apiService.loadData(
            host: host,
            endpoint: Endpoint.weather.rawValue,
            method: .get,
            parameters: parameters,
            model: WeatherModel.self
        ) { result in
            completion(result)
        }
    }
}
