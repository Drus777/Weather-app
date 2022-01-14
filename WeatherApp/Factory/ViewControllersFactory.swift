//
//  ViewControllersFactory.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

struct ViewControllersFactory {
    
    func weatherVC() -> UIViewController {
        let model = MainWeatherModel()
        let headerModel = HeaderModel(icon: "calendar", title: "Прогноз погоды на 8 дней")
        let headerView = HeaderView(by: headerModel)
        let view = MainWeatherView(dataSource: model.mainTableDataSource, headerView: headerView)
        let baseVC = BaseVC(view: view, model: model)
        return baseVC
    }
    
    func searchVC() -> UIViewController {
        let model = SearchModel()
        let view = SearchView(dataSource: model.searchTableDataSource)
        let searchVC = BaseVC(view: view, model: model)
        return searchVC
    }
}
