//
//  SearchView.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import UIKit

final class SearchView: UIView {

    // MARK: - UI
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
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
//        tableView.sectionHeaderTopPadding = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
