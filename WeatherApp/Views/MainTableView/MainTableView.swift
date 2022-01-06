//
//  MainTableView.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

//typealias UpdateData = Fillable & Output

final class MainTableView: UIView {
    
    var model: MainTableModel?
    
    // MARK: - UI
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sunnyBackground"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
    }
    
    init(_ model: MainTableModel) {
        self.init()
        self.model = model
        self.model?.loadData()
        configureViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Configure views
    
    private func configureViews() {
        configureBackgroundImageView()
        configureTableView()
    }
    
    private func configureBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.dataSource = model?.mainTableDataSource
        tableView.delegate = self
        tableView.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: CurrentWeatherTableCell.identifier)
        tableView.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: HourlyWeatherTableCell.identifier)
        tableView.register(DailyWeatherTableCell.self, forCellReuseIdentifier: DailyWeatherTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bind() {
        model?.cellModelsDidChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension MainTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height / 3
        }
        
        if indexPath.section == 1 {
            return 160
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}
