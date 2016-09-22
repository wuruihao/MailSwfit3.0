//
//  ApplicationCell.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/12.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class ApplicationCell: UITableViewCell {
    
    @IBOutlet weak var snap: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var type: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ data:LeaveData){
        
        snap.image = UIImage(named: "Login_male.png")
        name.text = data.name
        time.text = data.created
        title.text = String(format: "请假申请:%d天", data.time)
        department.text = data.department
        
        //未处理:0 被驳回:1 已批准:2 待我审批:3 已驳回:4 已审批:5
        switch data.status! as String{
        case "1":
            status.text = "未审批"
            status.textColor = RGBA(r: 122.0, g: 193.0, b: 229.0, a: 1.0)
            break
        case "2":
            status.text = "已通过"
            status.textColor = RGBA(r: 140.0, g: 140.0, b: 140.0, a: 1.0)
            break
        case "3":
            status.text = "未通过"
            status.textColor = UIColor.red
            break
        case "4":
            status.text = "已销毁"
            status.textColor = RGBA(r: 140.0, g: 140.0, b: 140.0, a: 1.0)
            break
        default:
            break
        }
        
    }
    
}
