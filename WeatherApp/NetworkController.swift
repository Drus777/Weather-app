//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Andrey on 5.01.22.
//

import Foundation

protocol LoadableNetwork {
    func fetchWeatherData(lat: String, lon: String, completion: @escaping (Result<WeatherResponseModel?, Error>) -> Void)
}

final class NetworkController: LoadableNetwork {
    
    private let apiService = APIService()
    
    func fetchWeatherData(lat: String, lon: String, completion: @escaping (Result<WeatherResponseModel?, Error>) -> Void) {
        
        let parameters = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
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
