//
//  DetailWeatherTableCell.swift
//  WeatherApp
//
//  Created by Andrey on 6.01.22.
//

import UIKit

class DetailWeatherTableCell: UITableViewCell {

    static let identifier = "DetailWeatherTableCell"
    
    var model: DetailWeatherModel? {
        didSet {
            collectionView.dataSource = model?.detailWeatherCollectionDataSource
            collectionView.reloadData()
        }
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(DetailWeatherCollectionCell.self, forCellWithReuseIdentifier: DetailWeatherCollectionCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailWeatherTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 10) / 2
        return .init(width: width, height: width)
    }
}
