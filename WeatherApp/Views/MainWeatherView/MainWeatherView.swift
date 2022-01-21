//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit
import SpriteKit

final class MainWeatherView: UIView {
    
    private var dataSource: WeatherTableDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    private let headerView: HeaderView
    
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
    
    init(headerView: HeaderView) {
        self.headerView = headerView
        super.init(frame: .zero)
//                        configureSkView()
//                        initSkScene()
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
        
        tableView.sectionHeaderTopPadding = 10
        tableView.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: CurrentWeatherTableCell.identifier)
        tableView.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: HourlyWeatherTableCell.identifier)
        tableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: DailyWeatherTableCell.identifier)
        tableView.register(DetailWeatherTableCell.self, forCellReuseIdentifier: DetailWeatherTableCell.identifier)
        tableView.register(MapWeatherTableCell.self, forCellReuseIdentifier: MapWeatherTableCell.identifier)
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
    // делать асинхронно
    private func initSkScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920)) //  изменить размеры
        particleScene.scaleMode = .aspectFill
        particleScene.backgroundColor = .clear
        
        DispatchQueue.main.async {
            self.skView.presentScene(particleScene)
        }
    }
}

// MARK: - UITableViewDelegate

extension MainWeatherView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return headerView.height
        } // хедер сам должен сказать, какая у него высота
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            return headerView
        } else {
            return nil
        }
    }
}

extension MainWeatherView: FillableView {
    func fill(by model: Model) {
        guard let model = model as? MainWeatherModel else { return }
        self.dataSource = model.weatherTableDataSource
    }
}
