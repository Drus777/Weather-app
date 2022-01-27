//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Andrey on 11.01.22.
//

import UIKit

class HeaderView: UIView {
    
    let height: CGFloat = 30
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray4
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = .zero
        label.textColor = .systemGray4
        return label
    }()
    
    init(by model: HeaderModel) {
        super.init(frame: .zero)
        configureViews(iconImage: model.icon, title: model.title)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configureViews(iconImage: String, title: String) {
        configureView()
        configureIconImageView()
        configureTitleLabel()
        iconImageView.image = UIImage(systemName: iconImage)
        titleLabel.text = title
    }
    
    private func configureView() {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        backgroundColor = .init(rgb: 0x6781B5).withAlphaComponent(0.85)
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func configureIconImageView() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
}
