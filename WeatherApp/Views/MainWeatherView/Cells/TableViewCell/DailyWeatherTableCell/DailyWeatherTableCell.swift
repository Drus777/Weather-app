//
//  DailyWeatherTableCell.swift
//  WeatherApp
//
//  Created by Andrey on 2.01.22.
//

import UIKit

final class DailyWeatherTableCell: UITableViewCell {
    
    static let identifier = "DailyWeatherTableCell"
    static let height: CGFloat = 60
    
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
    
    private var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = .zero
        label.textColor =  #colorLiteral(red: 0.442997992, green: 0.9458556771, blue: 0.9850631356, alpha: 1)
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        return view
    }()
    
    private var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray4
        return view
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
        configureSeparatorView()
        configureDayLabel()
        configureIconImageView()
        configurePrecipitationLabel()
        configureMinTempLabel()
        configureMaxTempLabel()
        configureLineView()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1).withAlphaComponent(0.85)
    }
    
    private func configureSeparatorView() {
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            separatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            separatorView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
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
            iconImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor)
        ])
    }
    
    private func configurePrecipitationLabel() {
        contentView.addSubview(precipitationLabel)
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            precipitationLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -8),
            precipitationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 105),
            precipitationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
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
    
    private func configureLineView() {
        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 210),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}

// MARK: - Fillable

extension DailyWeatherTableCell: Fillable {
    func fill(by cellModel: CellModels) {
        
        guard let cellModel = cellModel as? DailyWeatherCellDataModel  else { return }
        dayLabel.text = cellModel.day
        iconImageView.image = UIImage(named: cellModel.icon)
        minTempLabel.text = "\(Int(cellModel.minTemp))°"
        maxTempLabel.text = "\(Int(cellModel.maxTemp))°"
        
        if cellModel.precipitation == 0 {
            precipitationLabel.text = ""
        } else {
            precipitationLabel.text = "\(Int(cellModel.precipitation * 100))%"
        }
    }
}
