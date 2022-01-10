//
//  BottomView.swift
//  WeatherApp
//
//  Created by Andrey on 10.01.22.
//

import UIKit

class BottomView: UIView {
    
    // MARK: - UI
    
    private var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.4058402008, green: 0.5064953604, blue: 0.7112003601, alpha: 1)
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .clear
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configureViews() {
        configureLineView()
        configureBottomView()
    }
    
    private func configureLineView() {
        bottomView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            lineView.leftAnchor.constraint(equalTo: bottomView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: bottomView.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }
    
    private func configureBottomView() {
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
