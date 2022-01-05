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
        let view = MainTableView(model)
        let baseVC = BaseVC(view: view)
        return baseVC
    }
}
