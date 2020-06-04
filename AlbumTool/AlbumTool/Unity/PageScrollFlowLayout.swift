//
//  PageScrollFlowLayout.swift
//  AlbumTool
//
//  Created by L on 2020/5/28.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit

class PageScrollFlowLayout: UICollectionViewFlowLayout {
    
    var eachItemSize : CGSize!
    
    var minInterItemSpace : CGFloat = 15
    var minLineSpace : CGFloat = 15
    /// 记录上次滑动停止的offset值
    var lastOffset : CGPoint! = CGPoint.zero
    
    var  scrollAnimation : Bool = true
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
        //吸附效果
        self.collectionView?.decelerationRate = .fast
        self.itemSize = eachItemSize;
        self.minInterItemSpace = 15
        self.minInterItemSpace = 15
    }
    
    /// 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
    /// - Parameter proposedContentOffset: 偏移量
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let pageSpace = self.setSpace()
        let offsetMax : CGFloat = (self.collectionView?.contentSize.width)! - self.itemSize.width
        let offsetmin : CGFloat = 0.0;
        if (lastOffset.x < offsetmin){
            lastOffset.x = offsetmin
        }else if lastOffset.x > offsetMax{
            lastOffset.x = offsetMax
        }
               
               /// 目标位移点距离d绝对值
        let offsetForcurrentPointX = abs(proposedContentOffset.x - lastOffset.x)
        let velocityX = velocity.x
        let direction = (proposedContentOffset.x - lastOffset.x)>0
        var proposedContentOffsetPoint :CGPoint = CGPoint.zero
        if (offsetForcurrentPointX > pageSpace/8 && lastOffset.x >= offsetmin && lastOffset.x <= offsetMax){
            var pageFactor = 0
            if velocityX != 0 {
                pageFactor = Int(abs(velocityX))
            }else{
                pageFactor = Int(abs(offsetForcurrentPointX/pageSpace))
            }
            //设置pagefactor上限为2 防止滑动速率过大，导致翻页过多
            pageFactor = pageFactor < 1 ? 1 : (pageFactor < 3 ? 1:2)
            let pageOffsetX = pageSpace * CGFloat(pageFactor);
           proposedContentOffsetPoint  = CGPoint.init(x: lastOffset.x + (direction ? pageOffsetX: -pageOffsetX), y: proposedContentOffset.y)
        }else{
            proposedContentOffsetPoint = CGPoint.init(x: lastOffset.x, y: lastOffset.y)
            
        }
        lastOffset.x = proposedContentOffsetPoint.x
        debugPrint("X坐标偏移量 \(proposedContentOffsetPoint.x)")
        debugPrint("Y坐标偏移量 \(proposedContentOffsetPoint.y)")
        return proposedContentOffsetPoint
    }
  
    
    func setSpace() -> CGFloat{
        return self.eachItemSize.width + self.minLineSpace
    }
    func getCopyOfAttributes(attributes: Array<UICollectionViewLayoutAttributes>) -> Array<UICollectionViewLayoutAttributes>{
        let copyArr = NSMutableArray.init(capacity: 1)
        for attribute: UICollectionViewLayoutAttributes in attributes {
            copyArr.add(attribute.copy())
        }
        return copyArr as! Array<UICollectionViewLayoutAttributes>
    }
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        
//        let arr = self.getCopyOfAttributes(attributes: super.layoutAttributesForElements(in: rect)!)
//        if self.scrollAnimation {
//            let centerX = (self.collectionView?.contentOffset.x ?? 0) + (self.collectionView?.bounds.size.width)!/2.0
//            
//            for attributes : UICollectionViewLayoutAttributes in arr {
////                let distance = fabs(attributes.center.x - centerX)
////                let apartScale = distance/(self.collectionView?.bounds.size.width)!
////                let scale = fabs(cos(apartScale * CGFloat(M_PI/4)))
////                var plane_3d = CATransform3DIdentity
////                plane_3d = CATransform3DScale(plane_3d, 1, scale, 1);
////                attributes.transform3D = plane_3d
//            }
//        }
//        return arr
//    }
}
