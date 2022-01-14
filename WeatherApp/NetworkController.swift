//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

class NetworkController {
    
    private let apiService = APIService()
    
    func fetchWeatherData(lat: String, lon: String, units: Units, lang: Lang, completion: @escaping (Result<WeatherResponceModel?, Error>) -> Void) {
        
        let parameters = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "lang", value: lang.rawValue)
        ]
        
        apiService.loadData(
            endpoint: Endpoints.weather.rawValue,
            method: .get,
            parameters: parameters,
            responceModel: WeatherResponceModel.self
        ) { result in
            completion(result)
        }
    }
}
