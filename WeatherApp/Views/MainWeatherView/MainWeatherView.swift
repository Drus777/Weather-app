//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit
import SpriteKit

final class MainWeatherView: UIView {
    
    private var dataSource: MainTableDataSource? {
        didSet {
            self.tableView.dataSource = dataSource
        }
    }
    
    // MARK: - UI
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let skView: SKView = {
        let skView = SKView()
        skView.backgroundColor = .clear
        return skView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureSkView()
//        initSkScene()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Configure views
    
    private func configureViews() {
        configureTableView()
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 15
        tableView.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: CurrentWeatherTableCell.identifier)
        tableView.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: HourlyWeatherTableCell.identifier)
        tableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: DailyWeatherTableCell.identifier)
        tableView.register(DetailWeatherTableCell.self, forCellReuseIdentifier: DetailWeatherTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureSkView() {
        addSubview(skView)
        skView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: topAnchor),
            skView.leftAnchor.constraint(equalTo: leftAnchor),
            skView.rightAnchor.constraint(equalTo: rightAnchor),
            skView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func initSkScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        particleScene.backgroundColor = .clear
        
        skView.presentScene(particleScene)
    }
}

// MARK: - UITableViewDelegate

extension MainWeatherView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height / 3
        }
        
        if indexPath.section == 1 {
            return 160
        }
        
        if indexPath.section == 3 {
            return tableView.bounds.width * 2
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let headerView = HeaderView(iconImage: UIImage(systemName: "calendar")!, title: "Прогноз погоды на 8 дней")
            return headerView
        } else {
            return nil
        }
    }
}

extension MainWeatherView: Updating {
    func fill(by dataSource: UITableViewDataSource) {
        if let dataSource = dataSource as? MainTableDataSource {
            self.dataSource = dataSource
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
