//
//  MediaPlayCollectionViewCell.swift
//  AlbumTool
//
//  Created by L on 2020/5/29.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit

class MediaPlayCollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView?
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView.init(frame: kFrameMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        self.addSubview(self.imageView!)
       

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
