//
//  AlbumModel.swift
//  AlbumTool
//
//  Created by L on 2020/5/28.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
import Photos

class  AlbumModel : NSObject{
    var asset : PHAsset? {
        didSet{
            let orginH = asset?.pixelHeight
            let orginW = asset?.pixelWidth
            let scale : CGFloat =  SCREEN_WIDTH / CGFloat(orginW!)
            let scaleH = CGFloat(orginH!) * scale
            let normalMaxH = SCREEN_HEIGHT - kSafeTopStatusHeight - kSafeBottomStatusHeight
            if scaleH > normalMaxH {
                viewHeight = normalMaxH
            }else{
                viewHeight = scaleH
            }
        }
    }
    var image : UIImage?
    
    
    var avAsset : AVAsset?
    
    var viewHeight :CGFloat = 0.0
}
