//
//  ViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/26.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    let tabTitles = ["ホーム", "口コミ", "カメラ"]
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var containerView: UIView!
    
    var startingScrollOffset: CGFloat = 0
    var pageViewController: ParentViewController!
    var maxHeaderHeight: CGFloat {
        return self.headerView.frame.size.height - self.headerView.tabCollectionView.frame.size.height / 2
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.tabCollectionView.dataSource = self
        headerView.tabCollectionView.delegate = self
        
        headerView.tabCollectionView.register(
            UINib(
                nibName: "HeaderTabCell",
                bundle: nil),
            forCellWithReuseIdentifier: "HeaderTabCell")
        
        bind()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageViewControllerSegue" {
            pageViewController = segue.destination as? ParentViewController
        }
    }
    
    func bind() {
        pageViewController.firstDidScroll.asSignal()
            .emit(onNext: { scroll in
                self.updateHeader( scrollDiff: scroll.0, isScrollUp: scroll.1)
            }).disposed(by: disposeBag)
    }
    
    func updateHeader(scrollDiff: CGFloat, isScrollUp: Bool) {
        var newY = self.scrollView.contentOffset.y
        
       // if isScrollingDown {
//            newY = max(-self.maxHeaderHeight, self.scrollView.contentOffset.y - abs(scrollDiff))
//
        if isScrollUp {
            newY = max(0, self.scrollView.contentOffset.y - abs(scrollDiff))
        } else {
            newY = min(self.maxHeaderHeight, self.scrollView.contentOffset.y + abs(scrollDiff))
        }
        
        if newY != self.scrollView.contentOffset.y {
            self.scrollView.contentOffset.y = newY
        }
        
//        if newUpperHeight != self.upperHeaderConstraint.constant {
//            self.updateHeader(scroll: newUpperHeight, derection: isScrollingDown)
//            self.upperHeaderConstraint.constant = newUpperHeight
//            self.setScrollPosition(self.startingScrollOffset)
//        }
    }
    
//    func scrollViewDidStopScrolling() {
//        let range = self.maxHeaderHeight
//        let midPoint = self.minHeaderHeight + (range / 2)
//
//        if self.headerHeightConstraint.constant > midPoint {
//            // ヘッダーセクションの高さが半分以上の時
//            self.expandHeader()
//        } else {
//            // ヘッダーセクションの高さが半分以下の時
//            self.collapseHeader()
//        }
//    }
//
//    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
//        // TableViewがスクロールできる範囲: ヘッダーセクションもスクロールすることも考慮
//        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
//
//        // Make sure that when header is collapsed, there is still room to scroll
//        return scrollView.contentSize.height > scrollViewMaxHeight
//    }
    
//    // ヘッダーセクションの高さをMinにする
//    func collapseHeader() {
//        self.view.layoutIfNeeded()
//        UIView.animate(withDuration: 0.2, animations: {
//            self.headerHeightConstraint.constant = self.minHeaderHeight
//            //self.updateHeader()
//            self.view.layoutIfNeeded()
//        })
//    }
//    
//    // ヘッダーセクションの高さをMaxにする
//    func expandHeader() {
//        self.view.layoutIfNeeded()
//        UIView.animate(withDuration: 0.2, animations: {
//            self.headerHeightConstraint.constant = self.maxHeaderHeight
//            //self.updateHeader()
//            self.view.layoutIfNeeded()
//        })
//    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: position)
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
