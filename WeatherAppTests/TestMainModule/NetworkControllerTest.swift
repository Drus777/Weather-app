//
//  NetworkControllerTest.swift
//  WeatherAppTests
//
//  Created by Andrey on 19.01.22.
//

import XCTest
@testable import WeatherApp

class NetworkControllerTest: XCTestCase {
    
    var networkController: NetworkController!
    var weatherResponse: WeatherResponseModel?
    
    override func setUpWithError() throws {
        networkController = NetworkController()
    }
    
    override func tearDownWithError() throws {
        networkController = nil
        weatherResponse = nil
    }
    
    func testFetchSuccesResponse() throws {
        
        let expectation = expectation(description: "Expectation in " + #function)
        
        networkController.fetchWeatherData(lat: "0", lon: "0") { result in
            switch result {
            case .success(let weatherResponse):
                self.weatherResponse = weatherResponse
                expectation.fulfill()
            case .failure(let error):
                print("\(#function) error handled: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                XCTFail()
            }
        }
        XCTAssertNotNil(weatherResponse)
    }
}
