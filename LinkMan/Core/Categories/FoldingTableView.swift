//
//  FoldingTableView.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/5.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

protocol FoldingSectionHeaderDelegate {
    
    func foldingSectionHeaderTappedAtIndex(_ index: NSInteger, isOpen:Bool)
}

class FoldingSectionHeader: UIView {
    
    var currentIsOpen: Bool!
    var sectionDelegate: FoldingSectionHeaderDelegate?
    
    init(frame: CGRect, tag: NSInteger) {
        
        super.init(frame: frame)
        
        self.tag = tag;
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ backgroundColor:UIColor, titleString:String, titleColor:UIColor, titleFont:UIFont, descriptionString:String, descriptionColor:UIColor, descriptionFont:UIFont, arrowImage:UIImage, currentIsOpen:Bool){
        
        self.backgroundColor = backgroundColor;
        
        arrowImageView.frame = CGRect(x:10, y: 0, width: 30, height: self.height)
        arrowImageView.image = arrowImage;
        
        titleLabel.frame = CGRect(x:arrowImageView.x+arrowImageView.width, y: arrowImageView.y, width: 60, height:self.height)
        titleLabel.text = titleString;
        titleLabel.textColor = titleColor;
        titleLabel.font = titleFont;
        
        descriptionLabel.frame = CGRect(x: self.width-50-10, y: titleLabel.y, width: 50, height: self.height)
        descriptionLabel.text = descriptionString;
        descriptionLabel.textColor = descriptionColor;
        descriptionLabel.font = descriptionFont
        
        self.currentIsOpen = currentIsOpen;
        
        //if currentIsOpen == true {
            
          //  arrowImageView.transform = CGAffineTransform(rotationAngle: 0)
       // }else{
            
           // arrowImageView.transform = CGAffineTransform(rotationAngle: 0);
        //}
        
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    fileprivate lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        return arrowImageView
    }()
    fileprivate lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.black
        return descriptionLabel
    }()
    
   // private lazy var tapGesture: UITapGestureRecognizer = {
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapped:)
        //return tapGesture
   // }()
    
    
    @objc fileprivate func onTapped(_ gesture:UITapGestureRecognizer){
        
        //UIView.animate(withDuration: 0.2, animations: {
            
         //   if self.currentIsOpen == true {
         //       self.arrowImageView.transform = CGAffineTransform(rotationAngle: 90)
         //   }else{
         //       self.arrowImageView.transform = CGAffineTransform(rotationAngle: 0);
         //   }
       // })
        
       // (sectionDelegate?.foldingSectionHeaderTappedAtIndex(index:self.tag, isOpen: self.currentIsOpen))!
    }
}

