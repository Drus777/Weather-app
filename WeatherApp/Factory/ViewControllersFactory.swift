//
//  ViewControllersFactory.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

struct ViewControllersFactory {

    static func weatherVC() -> UIViewController {
        let model = MainWeatherModel()
        let view = MainWeatherView()
        let baseVC = BaseVC(view: view, model: model)
        return baseVC
    }
    
    static func searchVC() -> UIViewController {
        let model = SearchModel()
        let view = SearchView()
        let searchVC = BaseVC(view: view, model: model)
        return searchVC
    }
}
