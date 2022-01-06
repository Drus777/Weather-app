//
//  DetailWeatherCollectionCell.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import UIKit

class DetailWeatherCollectionCell: UICollectionViewCell {
    
    static let identifier = "DetailWeatherCollectionCell"
    
    // MARK: - UI
    
    private var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .green
        return label
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
        configureCell()
        configureLabel()
    }
    
    private func configureCell() {
        contentView.backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1).withAlphaComponent(0.9)
        contentView.layer.cornerRadius = 15
    }
    
    private func configureLabel() {
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

extension DetailWeatherCollectionCell: Fillable {
    func fill(by cellModel: CellModels, index: Int?) {
        guard let cellModel = cellModel as? DetailWeatherCollectionCellModel else { return }
        
    }
}
