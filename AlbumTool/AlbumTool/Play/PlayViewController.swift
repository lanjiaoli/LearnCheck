//
//  PlayViewController.swift
//  AlbumTool
//
//  Created by L on 2020/5/28.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    let kCellIdentifier = "kCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: PageScrollFlowLayout!
    var dataSourceLists : [AlbumModel] = [];
    var avPlayer : AVPlayer?
    var playerLayer : AVPlayerLayer?
    var playItem : AVPlayerItem?
    /// 当前点击的坐标
    var currentIndex: NSInteger = 0
    var playerView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout.eachItemSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - GloabNavHeightAbove )
        self.collectionView.register(MediaPlayCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        let offsetX = self.collectionView.frame.width + 15
//        self.collectionView.setContentOffset(, animated:false)
        self.collectionView .layoutIfNeeded()
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.contentOffset = CGPoint.init(x: offsetX * CGFloat(currentIndex), y: self.collectionView.frame.origin.y);
        let cuttentModel = self.dataSourceLists[currentIndex]
        playerView = UIView.init(frame: kFrameMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        self.playItem = AVPlayerItem.init(asset: cuttentModel.avAsset!)
        self.avPlayer = AVPlayer.init(playerItem: self.playItem)
        self.playerLayer = AVPlayerLayer.init(player: self.avPlayer)
        self.playerLayer?.frame = playerView.frame
        self.view.addSubview (playerView)
        playerView.layer.addSublayer(self.playerLayer!)
        self.avPlayer?.play()
        self.navigationController?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
}
extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UIScrollViewDelegate{
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourceLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as! MediaPlayCollectionViewCell
        let model: AlbumModel = self.dataSourceLists[indexPath.item]
        cell.imageView!.image = model.image
        let Y = (cell.frame.height - model.viewHeight)/2.0
        cell.imageView?.frame = kFrameMake(0, Y, SCREEN_WIDTH, model.viewHeight)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("\(indexPath.row)")
    }
  
    
}

extension PlayViewController : UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: PlayViewController.self) {
            viewController.navigationController?
                .setNavigationBarHidden(true, animated: false)
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: PlayViewController.self) {
          
        }else{
            viewController.navigationController?
                .setNavigationBarHidden(false, animated: true)

        }
    }
}
