//
//  ParentViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/26.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ParentViewController: UIPageViewController {
    
    let firstDidScroll = PublishRelay<(CGFloat, Bool)>()
    private let disposeBag = DisposeBag()
    var firstVC: FirstViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        dataSource = self
        delegate = self
        
        
        setupVC()
        
        scrollToViewController(viewController: firstVC)
    }
    
    func setupVC() {
        firstVC = getFirst()
    }
    
    func getFirst() -> FirstViewController {
        let viewController = UIStoryboard(
            name: "ParentViewController",
            bundle: nil).instantiateViewController(
                withIdentifier: "FirstViewController") as! FirstViewController
        
        viewController.setup(didScroll: firstDidScroll)
        return viewController
    }
    
    func getSecond() -> SecondViewController {
        return UIStoryboard(
            name: "ParentViewController",
            bundle: nil).instantiateViewController(
                withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return UIStoryboard(
            name: "ParentViewController",
            bundle: nil).instantiateViewController(
                withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
    func scrollToViewController(viewController: UIViewController) {
        setViewControllers([viewController],
                           direction: .forward,
                           animated: true,
                           completion: { (finished) -> Void in
        })
    }
}

// MARK: UIPageViewControllerDataSource

extension ParentViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: ThirdViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return self.firstVC
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if viewController.isKind(of: FirstViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            return getThird()
        } else {
            return nil
        }
    }
    
}

extension ParentViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
    }
    
}
