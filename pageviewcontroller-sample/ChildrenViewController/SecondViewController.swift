//
//  SecondViewController.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/27.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondCollectionView.dataSource = self
    }

}
extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = secondCollectionView
            .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
}
