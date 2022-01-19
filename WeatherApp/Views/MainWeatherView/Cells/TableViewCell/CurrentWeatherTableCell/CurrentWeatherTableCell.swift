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
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private var currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 65, weight: .light)
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
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
        configureTempLabel()
        configureDescriptionLabel()
        configureMinMaxLabel()
    }
    
    private func configureCityNameLabel() {
        contentView.addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            cityNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            cityNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }
    
    private func configureTempLabel() {
        contentView.addSubview(currentTempLabel)
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            currentTempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            currentTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ])
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ])
    }
    
    private func configureMinMaxLabel() {
        contentView.addSubview(minMaxTempLabel)
        minMaxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minMaxTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            minMaxTempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            minMaxTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            minMaxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
}

extension CurrentWeatherTableCell: FillableCell {
    func fill(by cellModel: CellModel) {
        
        guard let cellModel = cellModel as? CurrentWeatherCellModel else { return }
        
        LocationService.shared.getCityName { [ weak self] (placemark, error) in
            if let placemark = placemark {
                self?.cityNameLabel.text = placemark.locality
            } else if let error = error {
                print("\(#function) error handled: \(error.localizedDescription)")
            } else {
                self?.cityNameLabel.text = cellModel.cityName
            }
        }
        
        currentTempLabel.text = "\(Int(cellModel.currentTemp))°"
        descriptionLabel.text = cellModel.description.capitalizeFirstLetter()
        minMaxTempLabel.text = "Макс.: \(Int(cellModel.maxTemp))°, мин.: \(Int(cellModel.minTemp))°"
    }
}
