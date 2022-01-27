//
//  MainWeatherModelTest.swift
//  WeatherAppTests
//
//  Created by Andrey on 20.01.22.
//

import XCTest
@testable import WeatherApp

class MockNetworkController: LoadableNetwork {
    
    var responseModel: WeatherResponseModel?
    
    init() {}
    
    convenience init(_ responseModel: WeatherResponseModel) {
        self.init()
        self.responseModel = responseModel
    }
    
    func fetchWeatherData(lat: String, lon: String, completion: @escaping (Result<WeatherResponseModel?, Error>) -> Void) {
        if let responseModel = responseModel {
            completion(.success(responseModel))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class MainWeatherModelTest: XCTestCase {
    
    var model: MainWeatherModel!
    var networkController: LoadableNetwork!
    var responseModel: WeatherResponseModel!
    
    override func tearDownWithError() throws {
        model = nil
        networkController = nil
    }
    
    func testGetSuccesResponseModel() throws {
        responseModel = .init(
            timezone: "Minsk",
            current: .init(temp: 10, weather: [], pressure: 1, humidity: 1, uvi: 1, visibility: 1, windSpeed: 1, feelsLike: 1, windDeg: 1, dewPoint: 1),
            hourly: [],
            daily: [])
        
        networkController = MockNetworkController(responseModel)
        model = .init(networkController: networkController)
        var weatherResponse: WeatherResponseModel?
        
        networkController.fetchWeatherData(lat: "0", lon: "0") { result in
            switch result {
            case .success(let response):
                weatherResponse = response
            case .failure(_):
                break
            }
        }
        
        XCTAssertNotNil(weatherResponse)
        XCTAssertEqual(weatherResponse?.timezone, responseModel.timezone)
    }
    
    func testGetFailureResponseModel() throws {
        
        networkController = MockNetworkController()
        model = .init(networkController: networkController)
        var catchError: Error?
        
        networkController.fetchWeatherData(lat: "0", lon: "0") { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
}
