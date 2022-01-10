//
//  Fillable.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

protocol Fillable where Self: UIView {
    func fill(by cellModel: CellModels, index: Int?)
}
