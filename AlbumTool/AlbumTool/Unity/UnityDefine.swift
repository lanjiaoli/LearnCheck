//
//  UnityDefine.swift
//  AlbumTool
//
//  Created by L on 2020/5/28.
//  Copyright © 2020 L. All rights reserved.
//

import Foundation
import UIKit
// 屏幕的宽
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public let isIphoneX = isIPHONEX()

public let GloabNavHeightAbove : CGFloat = isIphoneX ? 88.0 : 64.0

public let kSafeTopStatusHeight : CGFloat = isIphoneX ? 44 : 0.0

public let kSafeBottomStatusHeight : CGFloat = isIphoneX ? 34.0 : 0.0


public func kFrameMake(_ x: CGFloat,
                       _ y: CGFloat,
                       _ w: CGFloat,
                       _ h: CGFloat) ->CGRect{
    
    return CGRect.init(x: x, y: y, width: w, height: h);
}

func isIPHONEX() -> Bool{
    if UIDevice.current.userInterfaceIdiom == .phone{
        let maxlength = SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_WIDTH : SCREEN_HEIGHT;
        if (maxlength >= 812) {
            return true;
        }
    }
    return false;
}
