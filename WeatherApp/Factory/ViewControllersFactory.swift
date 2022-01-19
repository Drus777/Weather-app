//
//  ViewControllersFactory.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

struct ViewControllersFactory {
    
    func weatherVC() -> UIViewController {
        let model: UpdatableModel = MainWeatherModel()
        let headerModel = HeaderModel(icon: "calendar", title: "Прогноз погоды на 8 дней")
        let headerView = HeaderView(by: headerModel)
        let view = MainWeatherView(headerView: headerView)
        let baseVC = BaseVC(view: view, model: model)
        return baseVC
    }
    
    func searchVC() -> UIViewController {
        let model = SearchModel()
        let view = SearchView()
        let searchVC = BaseVC(view: view, model: model)
        return searchVC
    }
}
