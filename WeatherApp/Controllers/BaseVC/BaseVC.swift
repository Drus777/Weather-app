//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class BaseVC: UIViewController {
    
    private let currentView: Reloadable?
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
    
    init(view: Reloadable, model: Models) {
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
                self?.currentView?.reloadData()
            }
        }
        if let model = model as? SearchModel {
            self.currentView?.reloadData()
        }
    }
}





