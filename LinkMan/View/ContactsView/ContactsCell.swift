//
//  ContactsCell.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var sanpImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func telephone(_ sender: UIButton) {
        
        
        
    }
    
}
