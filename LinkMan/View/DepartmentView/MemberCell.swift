//
//  MemberCell.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/7.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {
    
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupUI() {
    
        sanpImage.x = self.width*0.05
        sanpImage.width = self.height*0.8
        sanpImage.height = self.height*0.8
        sanpImage.centerY = kFitHeight(value: 95);
        sanpImage.image = UIImage(named: "sanp.png")
        addSubview(sanpImage)
        
        nameLabel.text = "吴瑞豪"
        nameLabel.x = sanpImage.x+sanpImage.width+10
        nameLabel.height = 15
        nameLabel.y = sanpImage.y
        nameLabel.width = 60
        addSubview(nameLabel)
        
        positionLabel.text = "ios开发"
        positionLabel.x = nameLabel.x
        positionLabel.height = nameLabel.height
        positionLabel.y = nameLabel.y+nameLabel.height+5
        positionLabel.width = nameLabel.width
        addSubview(positionLabel)
    }
    
    /// 头像
    lazy var sanpImage: UIImageView = {
        let sanpImage = UIImageView()
        return sanpImage
    }()
    
    /// 名称
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.black
        return nameLabel
    }()

    /// 职位
    lazy var positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.font = UIFont.systemFont(ofSize: 15)
        positionLabel.numberOfLines = 0
        positionLabel.textColor = UIColor.lightGray
        return positionLabel
    }()
    
    internal var memberData: MemberData? {
        
        
        didSet{
            
            
        }
    }
    
    
    
}
