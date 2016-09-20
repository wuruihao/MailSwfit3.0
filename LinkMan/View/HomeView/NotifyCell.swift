//
//  NotifyCell.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/14.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class NotifyCell: UITableViewCell {

    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ data:NotifyData){
        
        snapImage.image = UIImage(named: data.snap!)
        name.text = data.name
        time.text = data.time
        title.text = data.title
        subTitle.text = data.subTitle
    }
}
