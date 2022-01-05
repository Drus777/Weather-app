//
//  CurrentWeatherCell.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

final class CurrentWeatherTableCell: UITableViewCell {
    
    static let identifier = "CurrentWeatherCell"
    
    // MARK: - UI
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 65, weight: .light)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        configueViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Configue views
    
    private func configueViews() {
        configureCityNameLabel()
        configureTitleLabel()
        configureDescriptionLabel()
        configureMinMaxLabel()
    }
    
    private func configureCityNameLabel() {
        addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(currentTempLabel)
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureMinMaxLabel() {
        addSubview(minMaxTempLabel)
        minMaxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minMaxTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension CurrentWeatherTableCell: Fillable {
    func fill(by cellModel: CellModels, index: Int? = nil) {
        guard let cellModel = cellModel as? CurrentWeatherCellModel else { return }
        cityNameLabel.text = cellModel.cityName
        currentTempLabel.text = "\(Int(cellModel.currentTemp))°"
        descriptionLabel.text = cellModel.description
        minMaxTempLabel.text = "Макс.: \(Int(cellModel.maxTemp))°, мин.: \(Int(cellModel.minTemp))°"
    }
}
