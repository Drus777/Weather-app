//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

final class NetworkController {
    
    private let apiService = APIService()
    
    func fetchWeatherData(lat: String, lon: String, units: Units, lang: Lang, apiKey: ApiKeys, completion: @escaping (Result<WeatherResponseModel?, Error>) -> Void) {
        
        let parameters = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "lang", value: lang.rawValue),
            URLQueryItem(name: "appid", value: apiKey.rawValue)
        ]
        
        apiService.loadData(
            endpoint: Endpoints.weather.rawValue,
            method: .get,
            parameters: parameters,
            responseModel: WeatherResponseModel.self
        ) { result in
            completion(result)
        }
    }
}
