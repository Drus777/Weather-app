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
    
    private var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = .zero
        label.textColor =  #colorLiteral(red: 0.442997992, green: 0.9458556771, blue: 0.9850631356, alpha: 1)
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
        imageView.tintColor = .systemYellow
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
        configurePrecipitationLabel()
        configureTempLabel()
    }

    private func configureTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func configureIconImage() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(greaterThanOrEqualTo: timeLabel.bottomAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func configurePrecipitationLabel() {
        contentView.addSubview(precipitationLabel)
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            precipitationLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -8),
            precipitationLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15),
            precipitationLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func configureTempLabel() {
        contentView.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

// MARK: - Fillable

extension HourlyWeatherCollectionCell: Fillable {
    
    private func dateConvertion(unixTime: Double, dateFormat: String) -> String {
        let time = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: time)
    }
    
    func fill(by cellModel: CellModels, index: Int?) {
        guard
            let cellModel = cellModel as? HourlyWeatherCollectionCellModel,
            let index = index,
            let time =  cellModel.weatherModel.hourly[index].dt,
            let temp = cellModel.weatherModel.hourly[index].temp,
            let icon = cellModel.weatherModel.hourly[index].weather[0].icon,
            let precipitation = cellModel.weatherModel.hourly[index].pop,
            let sunrise = cellModel.weatherModel.daily[0].sunrise,
            let sunset = cellModel.weatherModel.daily[0].sunset
        else { return }
        
        let sunriseHourMinute = dateConvertion(unixTime: Double(sunrise), dateFormat: "HH:mm")
        let sunsetHourMinute = dateConvertion(unixTime: Double(sunset), dateFormat: "HH:mm")
        
        let timeHour = dateConvertion(unixTime: Double(time), dateFormat: "HH")
        let sunriseHour = dateConvertion(unixTime: Double(sunrise), dateFormat: "HH")
        let sunsetHour = dateConvertion(unixTime: Double(sunset), dateFormat: "HH")
        
        if index == 0 {
            timeLabel.text = "Сейчас"
            tempLabel.text = "\(Int(temp))°"
            iconImageView.image = UIImage(named: icon)
            
            if precipitation == 0 {
                precipitationLabel.text = ""
            } else {
                precipitationLabel.text = "\(Int(precipitation * 100))%"
            }
        } else if timeHour == sunriseHour {
            timeLabel.text = sunriseHourMinute
            iconImageView.image = UIImage(systemName: "sunrise.fill")
            tempLabel.text = "Восход солнца"
            precipitationLabel.text = ""
        } else if timeHour == sunsetHour {
            timeLabel.text = sunsetHourMinute
            iconImageView.image = UIImage(systemName: "sunset.fill")
            tempLabel.text = "Заход солнца"
            precipitationLabel.text = ""
        } else {
            timeLabel.text = timeHour
            tempLabel.text = "\(Int(temp))°"
            iconImageView.image = UIImage(named: icon)
            
            if precipitation == 0 {
                precipitationLabel.text = ""
            } else {
                precipitationLabel.text = "\(Int(precipitation * 100))%"
            }
        }
    }
}


