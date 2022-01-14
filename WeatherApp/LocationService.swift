//
//  LocationService.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var lat: Double {
        return self.locationManager.location?.coordinate.latitude ?? 0
    }

    var lon: Double {
        return self.locationManager.location?.coordinate.longitude ?? 0
    }
    
    override init() {
        super.init()
        setupLocation()
    }
    
    func getCityName(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        
        if let lastLocation = self.locationManager.location {
            
            geocoder.reverseGeocodeLocation(lastLocation,  completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    completionHandler(nil)
                }
            })
        }
        else {
            completionHandler(nil)
        }
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    private func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            stop()
        }
    }
}
