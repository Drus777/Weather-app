//
//  ViewControllersFactory.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

struct ViewControllersFactory {

    static func weatherVC() -> UIViewController {
        let model = BaseModel()
//        let view = MainWeatherView(model)
//        let baseVC = BaseVC(view: view)
        let view = MainWeatherView()
        let baseVC = BaseVC(view: view, model: model)
        return baseVC
    }
}
