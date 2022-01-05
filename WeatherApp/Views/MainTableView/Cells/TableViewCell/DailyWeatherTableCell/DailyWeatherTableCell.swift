//
//  DailyWeatherTableCell.swift
//  WeatherApp
//
//  Created by Andrey on 2.01.22.
//

import UIKit

final class DailyWeatherTableCell: UITableViewCell {
    
    static let identifier = "DailyWeatherTableCell"
    
    // MARK: - UI
    
    private var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .systemGray4
        return label
    }()
    
    private var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Configue views
    
    private func configureViews() {
        configureCell()
        configureDayLabel()
        configureIconImageView()
        configureMinTempLabel()
        configureMaxTempLabel()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1).withAlphaComponent(0.9)
    }
    
    private func configureDayLabel() {
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    private func configureIconImageView() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureMinTempLabel() {
        contentView.addSubview(minTempLabel)
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minTempLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            minTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func configureMaxTempLabel() {
        contentView.addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            maxTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: - Fillable
extension DailyWeatherTableCell: Fillable {
    func fill(by cellModel: CellModels, index: Int?) {
        
        guard
            let cellModel = cellModel as? DailyWeatherTableCellModel,
            let index = index,
            let day = cellModel.dailyWeather[index].dt,
            let icon = cellModel.dailyWeather[index].weather[0].icon,
            let minTemp = cellModel.dailyWeather[index].temp?.min,
            let maxTemp = cellModel.dailyWeather[index].temp?.max
        else { return }
        let date = Date(timeIntervalSince1970: TimeInterval(day))
        let dateformater = DateFormatter()
        dateformater.dateFormat = "EE"
        dateformater.locale = Locale(identifier: "Ru-ru")
        let dateString = dateformater.string(from: date)
        
        if index == 0 {
            dayLabel.text = "Сегодня"
            iconImageView.image = UIImage(named: icon)
            minTempLabel.text = "\(Int(minTemp))°"
            maxTempLabel.text = "\(Int(maxTemp))°"
            layer.cornerRadius = 15
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            dayLabel.text = dateString
            iconImageView.image = UIImage(named: icon)
            minTempLabel.text = "\(Int(minTemp))°"
            maxTempLabel.text = "\(Int(maxTemp))°"
        }
        if index == (cellModel.dailyWeather.count - 1) {
            layer.cornerRadius = 15
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
}
