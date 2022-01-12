//
//  PageVC.swift
//  WeatherApp
//
//  Created by Andrey on 9.01.22.
//

import UIKit

final class PageVC: UIPageViewController {
    
    var controllers: [UIViewController] = [ViewControllersFactory.weatherVC(), ViewControllersFactory.weatherVC()]
    
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
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list-icon"), for: .normal)
        return button
    }()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        configureViews()
        setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configureViews() {
        configureBottomView()
        configureLineView()
        configureSearchButton()
    }
    
    private func configureBottomView() {
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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

    private func configureSearchButton() {
        bottomView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20),
            searchButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            searchButton.heightAnchor.constraint(equalToConstant: 18),
            searchButton.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? BaseVC else { return nil }
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            }
        }
         return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? BaseVC else { return nil }
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
