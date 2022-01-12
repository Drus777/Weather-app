//
//  Updatable.swift
//  WeatherApp
//
//  Created by Andrey on 11.01.22.
//

import UIKit

protocol Updating where Self: UIView {
    func fill(by dataSource: UITableViewDataSource)
    func reloadData()
}
