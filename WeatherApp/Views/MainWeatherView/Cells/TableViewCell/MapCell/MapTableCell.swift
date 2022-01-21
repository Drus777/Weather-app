//
//  MapTableCell.swift
//  WeatherApp
//
//  Created by Алексей Авдейчик on 21.01.22.
//

import UIKit
import MapKit
import CoreLocation

class MapTableCell: UITableViewCell {
    
    static let identifier = "MapCell"
    
    var cellModel: MapCellModel?
    
    var output: BaseVCOutput?
    
    //MARK: UI
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 10
        mapView.mapType = .hybrid
        return mapView
    }()
    
    let locationManager = CLLocationManager()
    
    let annotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.902284, longitude: 27.561831)
        annotation.subtitle = "Minsk"
        annotation.title = "-3"
        return annotation
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mapView.addAnnotation(annotation)
        backgroundColor = .init(rgb: 0x6781B5).withAlphaComponent(0.85)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        configureViews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: Setup
    
    private func setup() {
        checkLocationEnabled()
    }
    
    private func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
        } else {
            let alert = UIAlertController(title: "У Вас выключена служба геолокации", message: "Включить службу геолокации?", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { alert in
                if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            output?.present(controller: alert)
        }
    }
    
    private func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // точность позиции
    }
    
    private func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    //MARK: Configure
    
    private func configureViews(){
        configureMapView()
    }
    
    
    private func configureMapView() {
        contentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            mapView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
//MARK: fillable
extension MapTableCell: FillableCell {
    
    
    func fill(by cellModel: CellModel) {
        guard let cellModel = cellModel as? MapCellModel else { return }
        LocationService.shared.getCityName { [ weak self] (placemark, error) in
            guard let self = self else {return}
            let lat = LocationService.shared.coordinate?.latitude
            let lon = LocationService.shared.coordinate?.longitude
            self.annotation.title = "\(Int(cellModel.currentTemp))°"
            self.annotation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0)
        }
    }
}

//MARK: Location Delegate
extension MapTableCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}

