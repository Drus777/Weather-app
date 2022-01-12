//
//  PageVC.swift
//  WeatherApp
//
//  Created by Andrey on 9.01.22.
//

import UIKit

final class PageVC: UIPageViewController {
    
    private let bottomView = BottomView()
    
    private var controllers: [UIViewController] = [ViewControllersFactory.weatherVC(), ViewControllersFactory.weatherVC()]

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        configureBottomView()
        setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        return nil
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
