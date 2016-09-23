//
//  StaffInformationController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/8.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class StaffInformationController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var workMailbox: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    var memberData: MemberData!
    var type: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if type == "经理" {
            editBtn.isHidden = false
        }else {
            editBtn.isHidden = true
        }
        
        setData(data: memberData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func editInfoAction(_ sender: UIButton) {
        
        if type == "经理" {
            
            let addContactsVC = AddContactsController()
            addContactsVC.type = "编辑"
            addContactsVC.memberData = memberData
            self.navigationController?.pushViewController(addContactsVC, animated: true)
            
        }else {
            
            //网络请求添加到常联系人
            
        }
        
    }
    
    func setData(data:MemberData){
        
        name.text = data.name
        subTitle.text = data.department
        phoneNum.text = data.mobile
        workMailbox.text = data.email
    }
    
}
