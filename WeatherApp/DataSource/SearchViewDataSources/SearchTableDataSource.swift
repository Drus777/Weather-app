//
//  SearchTableDataSource.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import UIKit

final class SearchTableDataSource: NSObject, UITableViewDataSource {
    
    private var searchModel: SearchTableModel?
    
    init(_ searchModel: SearchTableModel) {
        self.searchModel = searchModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as? CityTableCell else { return .init() }
        
        return cell
    }
}
