//
//  FillableCell.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

protocol FillableCell where Self: UIView {
    func fill(by cellModel: CellModel)
}


