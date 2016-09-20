//
//  HomeCell.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/8.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon.clipsToBounds = true
        icon.layer.cornerRadius = icon.width*0.5
    }

}
