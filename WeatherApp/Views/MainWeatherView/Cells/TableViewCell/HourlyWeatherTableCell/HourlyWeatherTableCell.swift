//
//  HourlyWeatherTableCell.swift
//  WeatherApp
//
//  Created by Andrey on 31.12.21.
//

import UIKit

final class HourlyWeatherTableCell: UITableViewCell {
    
    static let identifier = "HourlyWeatherTableCell"
    
    var cellModel: HourlyWeatherCollectionCellModel?
    
    var dataSource: HourlyWeatherCollectionDataSource? {
        didSet {
            collectionView.dataSource = dataSource
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
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
    
    private func configureViews(){
        configureCell()
        configureIntoLabel()
        configureLineView()
        configureCollectionView()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1).withAlphaComponent(0.95)
        layer.cornerRadius = 15
    }
    
    private func configureIntoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
    
    private func configureLineView() {
        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(HourlyWeatherCollectionCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lineView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HourlyWeatherTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let minWidth: CGFloat = collectionView.bounds.width / 6
        var textWidth: CGFloat = 0
        let height = collectionView.bounds.height
        
        if let time = cellModel?.weatherModel.hourly[indexPath.item].dt,
           let temp = cellModel?.weatherModel.hourly[indexPath.item].temp,
           let sunrise = cellModel?.weatherModel.daily[0].sunrise,
           let sunset = cellModel?.weatherModel.daily[0].sunset {
            
            let timeHour = dateConvertion(unixTime: Double(time), dateFormat: "HH")
            let sunriseHour = dateConvertion(unixTime: Double(sunrise), dateFormat: "HH")
            let sunsetHour = dateConvertion(unixTime: Double(sunset), dateFormat: "HH")
            
            if indexPath.item == 0 {
                textWidth = "\(Int(temp))".width(withConstrainedHeight: CGFloat(18), font: .systemFont(ofSize: 18, weight: .medium))
            } else if timeHour == sunriseHour {
                let text = "Восход солнца"
                textWidth = text.width(withConstrainedHeight: CGFloat(18), font: .systemFont(ofSize: 18, weight: .medium))
            } else if timeHour == sunsetHour {
                let text = "Заход солнца"
                textWidth = text.width(withConstrainedHeight: CGFloat(18), font: .systemFont(ofSize: 18, weight: .medium))
            } else {
                textWidth = "\(Int(temp))".width(withConstrainedHeight: CGFloat(18), font: .systemFont(ofSize: 18, weight: .medium))
            }
        }
        
        return .init(width: max(minWidth, textWidth), height: height)
    }
    
    private func dateConvertion(unixTime: Double, dateFormat: String) -> String {
        let time = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: time)
    }
}

extension HourlyWeatherTableCell: Fillable {
    func fill(by cellModel: CellModels, index: Int? = nil) {
        guard let cellModel = cellModel as? HourlyWeatherTableCellModel else { return }
        infoLabel.text = cellModel.info
    }
}
