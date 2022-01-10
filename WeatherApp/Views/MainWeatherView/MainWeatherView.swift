//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

protocol Updating where Self: UIView {
    func fill(by model: BaseModel)
    func reloadData()
}

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
        tableView.separatorColor = .systemGray4
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        tableView.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: CurrentWeatherTableCell.identifier)
        tableView.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: HourlyWeatherTableCell.identifier)
        tableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: DailyWeatherTableCell.identifier)
        tableView.register(DetailWeatherTableCell.self, forCellReuseIdentifier: DetailWeatherTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
        //        if section == 2 {
        //            return 0
        //        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}

extension MainWeatherView: Updating {
    func fill(by model: BaseModel) {
        self.dataSource = model.mainTableDataSource
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
