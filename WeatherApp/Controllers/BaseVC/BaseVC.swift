//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

protocol BaseVCOutput: AnyObject {
    func present(controller: UIViewController)
}

final class BaseVC: UIViewController {
    
    private let currentView: FillableView?
    private var model: Model?
    
    override func loadView() {
        view = currentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = model as? UpdatableModel {
            model.loadData()
        }
        bind()
    }
    
    init(view: FillableView, model: Model) {
        self.currentView = view
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func bind() {
        if let model = model as? MainWeatherModel {
            model.weatherTableCellModelsDidChange = { [weak self] in
                self?.currentView?.fill(by: model)
            }
        }
    }
}

extension BaseVC: BaseVCOutput {
    func present(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
}




