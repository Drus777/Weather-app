//
//  BottomView.swift
//  WeatherApp
//
//  Created by Andrey on 12.01.22.
//

import UIKit

protocol BottomViewDelegate: AnyObject{
    func didTapButton()
}

final class BottomView: UIView {
    
    weak var delegate: BottomViewDelegate?

    private var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list-icon"), for: .normal)
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configureViews() {
        backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1)
        configureLineView()
        configureSearchButton()
    }
    
    private func configureLineView() {
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }

    private func configureSearchButton() {
        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            searchButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            searchButton.heightAnchor.constraint(equalToConstant: 18),
            searchButton.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    @objc private func didTapContinueButton() {
        delegate?.didTapButton()
    }
}
