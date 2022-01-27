//
//  FillableView.swift
//  WeatherApp
//
//  Created by Andrey on 19.01.22.
//

import UIKit

protocol FillableView where Self: UIView {
    func fill(by model: Model)
}
