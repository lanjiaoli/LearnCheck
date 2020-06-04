//
//  ViewController.swift
//  AlbumTool
//
//  Created by L on 2020/5/28.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let kCellIndetifier  = "AlbumCollectionViewCell"

    var dataSourceLists : [AlbumModel] = [];

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView .register(UINib.init(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCellIndetifier)
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize.init(width: (width-20)/3.0, height: (width-20)/3.0)
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .restricted {
                debugPrint("没有权限")
            }else{
                self .getAlbumData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourceLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIndetifier, for: indexPath) as! AlbumCollectionViewCell
        let model: AlbumModel = self.dataSourceLists[indexPath.item]
        cell.imagView.image = model.image
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let playVC = storyboard.instantiateViewController(identifier: "playController") as! PlayViewController
        playVC.dataSourceLists = dataSourceLists
        playVC.currentIndex = indexPath.item
        self.navigationController?.pushViewController(playVC, animated: true)
        
        
    }
}


extension ViewController{
    func getAlbumData() {
        let allPhotoOptions = PHFetchOptions()
        //按照时间排序
//        allPhotoOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: allPhotoOptions)
        for index in 0...smartAlbums.count {
            let options = PHFetchOptions.init()
            options.predicate = NSPredicate.init(format: "mediaType == %ld", PHAssetMediaType.video.rawValue)//˙只选视频
            let  collection : PHAssetCollection = smartAlbums[index]
            if collection.assetCollectionSubtype == PHAssetCollectionSubtype.smartAlbumUserLibrary {
                let fetchResult = PHAsset.fetchAssets(in: collection, options: options)
                fetchResult.enumerateObjects {[weak self] (asset, index, stop) in
                    let  model = AlbumModel()
                    model.asset = asset
                    let requestOptions = PHImageRequestOptions.init()
                    requestOptions.resizeMode = .fast
                    let size = CGSize.init(width: asset.pixelWidth, height: asset.pixelHeight)
                    PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: requestOptions) { (image, map) in
                        model.image = image
                    }
                    let videoRequestOptions  = PHVideoRequestOptions.init()

                    PHImageManager.default().requestAVAsset(forVideo: asset, options: videoRequestOptions) { (avasset, _, _) in
                        model.avAsset = avasset
                    }
                    self?.dataSourceLists.append(model)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
                break;
                }
            
                
            }
        }
        
}
