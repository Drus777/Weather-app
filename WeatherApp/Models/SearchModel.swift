//
//  SearchModel.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import Foundation

protocol SearchTableModel: AnyObject, Model {
    var searchTableDataSource: SearchTableDataSource { get }
}

final class SearchModel: SearchTableModel {
    var searchTableDataSource = SearchTableDataSource()
}
