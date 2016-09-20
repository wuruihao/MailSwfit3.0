//
//  MyCollectionViewLayout.swift
//  UICollectionViewDemo
//
//  Created by duzhe on 15/9/4.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class MyCollectionViewLayout: UICollectionViewLayout {

    fileprivate var _cellCount:Int?
    fileprivate var _collectSize:CGSize?
    fileprivate var _center:CGPoint?
    fileprivate var _radius:CGFloat?
    fileprivate let ITEM_SIZE:CGFloat = 70.0
    fileprivate var insertIndexPaths = [IndexPath]()
    
    //一般在该方法中设定一些必要的layout的结构和初始需要的参数等
    override func prepare() {
        super.prepare()
        _collectSize = self.collectionView?.frame.size
        _cellCount = self.collectionView?.numberOfItems(inSection: 0)
        _center = CGPoint(x: _collectSize!.width / 2.0, y: _collectSize!.height / 2.0);
        _radius = min(_collectSize!.width, _collectSize!.height)/2.5
    }

    //内容区域的总大小 （不是可见区域）
    override var collectionViewContentSize : CGSize {
        return _collectSize!  //这里不用可见区域吧
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
     
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self._cellCount {
            for i in 0 ..< count{
                //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
                let indexPath = IndexPath(item: i, section: 0)
                let attributes =  self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.size = CGSize(width: ITEM_SIZE, height: ITEM_SIZE)
        let x = Double(_center!.x) + Double(_radius!) * cos(Double(2 * (indexPath as NSIndexPath).item) * M_PI/Double(_cellCount!))
        let y = Double(_center!.y) + Double(_radius!) * sin(Double(2 * (indexPath as NSIndexPath).item) * M_PI/Double(_cellCount!))
        attrs.center = CGPoint( x: CGFloat(x) , y: CGFloat(y));
        return attrs
    }
    
    
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // Must call super
        var attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        if self.insertIndexPaths.contains(itemIndexPath) {
        
            if let _ = attributes{
                attributes = self.layoutAttributesForItem(at: itemIndexPath)
            }
            
            // Configure attributes ...
            attributes!.alpha = 0.0;
            attributes!.center =  CGPoint(x: _center!.x, y: _center!.y);
            //attributes?.size = CGSizeMake(1000, 1000)
        }
        
        return attributes;
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        self.insertIndexPaths = [IndexPath]()
        for update in updateItems{
            if update.updateAction == UICollectionUpdateAction.insert{
                self.insertIndexPaths.append(update.indexPathAfterUpdate!)
            }
    }
        
        
}
    

    
}
