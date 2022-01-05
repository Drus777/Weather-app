//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class BaseVC: UIViewController {
    
    private let currentView: UIView?
    
    override func loadView() {
        view = currentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(view: UIView) {
        self.currentView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}



