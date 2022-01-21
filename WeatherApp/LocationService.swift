//
//  LocationService.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import Foundation
import CoreLocation

final class LocationService: NSObject { // переименовать в менеджер?
    
    static let shared = LocationService()
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var coordinate: CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
    
    private override init() {
        super.init()
        setupLocation()
        start()
    }
    
    func getCityName(completionHandler: @escaping (CLPlacemark?, Error?) -> Void ) {
        
        guard let lastLocation = locationManager.location else { return completionHandler(nil, nil) }
        geocoder.reverseGeocodeLocation(lastLocation,  completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation, nil)
            } else {
                completionHandler(nil, error)
            }
        })
    }
    
    private func start() {
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
        stop()
    }
}
