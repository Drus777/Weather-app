//
//  SearchView.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import UIKit

final class SearchView: UIView {
    
    private var dataSource: SearchTableDataSource? {
        didSet {
            self.tableView.dataSource = dataSource
        }
    }
    
    // MARK: - UI
    
    private var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
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
        configureBackgroundView()
        configureTableView()
    }
    
    private func configureBackgroundView() {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.delegate = self
//        tableView.sectionHeaderTopPadding = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension SearchView: UITableViewDelegate {
    
}

extension SearchView: Updating {
    func fill(by dataSource: UITableViewDataSource) {
        if let dataSource = dataSource as? SearchTableDataSource {
            self.dataSource = dataSource
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
