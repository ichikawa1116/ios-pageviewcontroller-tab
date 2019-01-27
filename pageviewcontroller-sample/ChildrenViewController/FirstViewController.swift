//
//  FirstViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/27.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FirstViewViewItem {
    func setup(didScroll: PublishRelay<(CGFloat, Bool)>)
}

class FirstViewController: UIViewController {

    @IBOutlet weak var firstTableView: UITableView!
    var didScroll: PublishRelay<(CGFloat, Bool)>!
    var startingScrollOffset: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstTableView.dataSource = self
        self.firstTableView.delegate = self

    }

}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = "First View Cell: \(indexPath.row)"
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - 0
        // 上にスクロール
        let isScrollingUp = scrollView.contentOffset.y < startingScrollOffset
        didScroll.accept((scrollDiff, isScrollingUp))
        setScrollPosition(0)
        
        startingScrollOffset = scrollView.contentOffset.y
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.firstTableView.contentOffset = CGPoint(x: self.firstTableView.contentOffset.x, y: position)
    }
    
//    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
//        // TableViewがスクロールできる範囲: ヘッダーセクションもスクロールすることも考慮
//        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
//
//        // Make sure that when header is collapsed, there is still room to scroll
//        return scrollView.contentSize.height > scrollViewMaxHeight
//    }
}

extension FirstViewController: FirstViewViewItem {
    
    func setup(didScroll: PublishRelay<(CGFloat, Bool)>) {
        self.didScroll = didScroll
    }
}
