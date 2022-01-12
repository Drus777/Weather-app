//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class BaseVC: UIViewController {
    
    private let currentView: Updating?
    private var model: Models?
    
    override func loadView() {
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = model as? MainTableModel {
            model.loadData()
        }
        bind()
    }
    
    init(view: Updating, model: Models) {
        self.currentView = view
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func bind() {
        if let model = model as? MainWeatherModel {
            model.cellModelsDidChange = { [weak self] in
                self?.currentView?.fill(by: model.mainTableDataSource)
                self?.currentView?.reloadData()
            }
        }
        if let model = model as? SearchModel {
            self.currentView?.fill(by: model.searchTableDataSource)
            self.currentView?.reloadData()
        }
    }
}





