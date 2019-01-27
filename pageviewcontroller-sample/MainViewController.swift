//
//  ViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/26.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let tabTitles = ["ホーム", "口コミ", "カメラ"]
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var containerView: UIView!
    
    var pageViewController: ParentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.tabCollectionView.dataSource = self
        headerView.tabCollectionView.delegate = self
        
        headerView.tabCollectionView.register(
            UINib(
                nibName: "HeaderTabCell",
                bundle: nil),
            forCellWithReuseIdentifier: "HeaderTabCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageViewControllerSegue" {
            pageViewController = segue.destination as? ParentViewController
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return tabTitles.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderTabCell",
                                                      for: indexPath) as! HeaderTabCell
        cell.upperTitleLabel.text = tabTitles[indexPath.row]
        cell.titleLabel.text = "100"
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize:CGFloat = self.view.bounds.width/3 - 4
        return CGSize(width: cellSize, height: cellSize / 2 + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 2 , bottom: 0 , right: 2 )
    }
    
    // 水平方向におけるセル間のマージン
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 垂直方向におけるセル間のマージン
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            pageViewController.scrollToViewController(
                viewController: pageViewController.getFirst())
        } else if indexPath.row == 1 {
            pageViewController.scrollToViewController(
                viewController: pageViewController.getSecond())
        } else if indexPath.row == 2 {
        pageViewController.scrollToViewController(
            viewController:pageViewController.getThird())
        }
    }
}
