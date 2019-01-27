//
//  HeaderView.swift
//  pageviewcontroller-sample
//
//  Created by Manami Ichikawa on 2019/01/27.
//  Copyright © 2019 Manami Ichikawa. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    fileprivate func loadNib() {
        guard let view = UINib(nibName: "HeaderView",
                               bundle: nil).instantiate(withOwner: self,
                                                        options: nil).first as? UIView else {
            return
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
}
