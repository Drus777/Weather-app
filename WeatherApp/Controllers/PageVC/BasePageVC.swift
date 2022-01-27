//
//  BasePageVC.swift
//  WeatherApp
//
//  Created by Andrey on 9.01.22.
//

import UIKit

final class BasePageVC: UIPageViewController {
    
    private let bottomView = BottomView()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        configureBottomView()
        setViewControllers([ViewControllersFactory().weatherVC()], direction: .forward, animated: true, completion: nil)
        self.delegate = self
        self.dataSource = self
        bottomView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    private func presentSearchVC() {
        present(ViewControllersFactory().searchVC(), animated: true, completion: nil)
    }
}

extension BasePageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? BaseVC,
              let controllers = viewControllers,
              let index = controllers.firstIndex(of: viewController)
        else { return nil }
        if index > 0 {
            return controllers[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? BaseVC,
              let controllers = viewControllers,
              let index = controllers.firstIndex(of: viewController)
        else { return nil }
        if index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers?.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension BasePageVC: BottomViewDelegate {
    func didTapButton() {
        presentSearchVC()
    }
}
