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
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray4
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .systemGray4
        return label
    }()
    
    private var dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = .zero
        label.textColor = .white
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
        configureIconImageView()
        configureTitleLabel()
        configureDataLabel()
        configureInfoLabel()
    }
    
    private func configureCell() {
        contentView.backgroundColor = .init(rgb: 0x6781B5).withAlphaComponent(0.85)
        contentView.layer.cornerRadius = 15
    }
    
    private func configureIconImageView() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ])
    }
    
    private func configureDataLabel() {
        contentView.addSubview(dataLabel)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dataLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            infoLabel.topAnchor.constraint(greaterThanOrEqualTo: dataLabel.bottomAnchor, constant: 8),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension DetailWeatherCollectionCell: FillableCell {
    func fill(by cellModel: CellModel) {
        guard let cellModel = cellModel as? DetailCellDataModel else { return }
        iconImageView.image = UIImage(systemName: cellModel.icon)
        titleLabel.text = cellModel.title
        dataLabel.text = cellModel.data
        infoLabel.text = cellModel.info
    }
}
