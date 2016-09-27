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
    
    func setData(data:MemberData){

        if data.head_img != nil {
            sanpImage.sd_setImage(with: URL.init(string: data.head_img!), placeholderImage: UIImage(named: "sanp.png"))
        }else{
            sanpImage.image = UIImage(named: "sanp.png")
        }
        if data.name != nil {
            name.text = data.name
        }
        if data.level != nil {
            subTitle.text = data.level
        }

    }
    
}
