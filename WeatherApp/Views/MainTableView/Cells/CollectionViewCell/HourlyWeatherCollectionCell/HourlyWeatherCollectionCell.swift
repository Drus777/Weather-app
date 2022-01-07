//
//  HourlyWeatherCollectionCell.swift
//  WeatherApp
//
//  Created by Andrey on 31.12.21.
//

import UIKit

final class HourlyWeatherCollectionCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCollectionCell"
    
    // MARK: - UI
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var tempLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Configure views
    
    private func configureViews() {
        configureTimeLabel()
        configureIconImage()
        configureTempLabel()
    }
    
    private func configureTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureIconImage() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureTempLabel() {
        contentView.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

// MARK: - Fillable

extension HourlyWeatherCollectionCell: Fillable {
    
    func dateConvertion(unixTime: Double, dateFormat: String) -> String {
        let time = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: time as Date)
    }
    
    func fill(by cellModel: CellModels, index: Int?) {
        guard
            let cellModel = cellModel as? HourlyWeatherCollectionCellModel,
            let index = index,
            let time =  cellModel.weatherModel.hourly[index].dt,
            let temp = cellModel.weatherModel.hourly[index].temp,
            let icon = cellModel.weatherModel.hourly[index].weather[0].icon,
            let sunrise = cellModel.weatherModel.current.sunrise,
            let sunset = cellModel.weatherModel.current.sunset
        else { return }
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateformater = DateFormatter()
        dateformater.dateFormat = "HH"
        let dateString = dateformater.string(from: date)
        
        let sunriseHourMinute = dateConvertion(unixTime: Double(sunrise), dateFormat: "hh:mm")
        let sunsetHourMinute = dateConvertion(unixTime: Double(sunset), dateFormat: "hh:mm")
        
        let sunriseHour = dateConvertion(unixTime: Double(sunrise), dateFormat: "HH")
        let sunsetHour = dateConvertion(unixTime: Double(sunset), dateFormat: "HH")
        
        if index == 0 {
            timeLabel.text = "Сейчас"
            tempLabel.text = "\(Int(temp))°"
            iconImageView.image = UIImage(named: icon)
            
        } else if dateString == sunriseHour {
            timeLabel.text = sunriseHourMinute
            iconImageView.image = UIImage(systemName: "sunrise")
            tempLabel.text = "Восход солнца"
            
        } else if dateString == sunsetHour {
            timeLabel.text = sunsetHourMinute
            iconImageView.image = UIImage(systemName: "sunset")
            tempLabel.text = "Заход солнца"
            
        } else {
            timeLabel.text = dateString
            tempLabel.text = "\(Int(temp))°"
            iconImageView.image = UIImage(named: icon)
        }
    }
}
