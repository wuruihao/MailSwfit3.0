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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editInfoAction(_ sender: UIButton) {
        
        if type == "经理" {
            
            self.navigationController?.pushViewController(AddContactsController(), animated: true)
            
        }else {
            
            //网络请求添加到常联系人
            
        }
        
    }
}
