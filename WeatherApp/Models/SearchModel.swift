//
//  SearchModel.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import Foundation

protocol SearchTableModel: AnyObject {
    var mainTableDataSource: MainTableDataSource { get }
    var cellModelsDidChange: (() -> Void)? { get set }
    
    func loadData()
}
