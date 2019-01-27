//
//  FirstViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/27.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var firstTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstTableView.dataSource = self
        

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
        let scrollDiff = scrollView.contentOffset.y
        
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        
        // 下にスクロール
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        // 上にスクロール
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
    }
}
