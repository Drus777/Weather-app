//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit
//import SpriteKit

final class BaseVC: UIViewController {
    
    private let currentView: Updating?
    private  var model: MainTableModel?
    private let locationService = LocationService.shared
    
    override func loadView() {
        view = currentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model?.loadData()
        bind()
    }
    
    init(view: Updating, model: MainTableModel) {
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
                self?.currentView?.fill(by: model)
                self?.currentView?.reloadData()
            }
        }
    }
}



