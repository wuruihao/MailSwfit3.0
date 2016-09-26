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
    
    @IBAction func calPhone(_ sender: UIButton) {
        
        // 创建
        var alertController:UIAlertController!
        var callAction:UIAlertAction!
        var meaasge:String!
        
        switch sender.tag {
        case 0:
            meaasge = String(format: "你确定要向%@发短信", memberData.mobile!)
            alertController = UIAlertController(title: "发短信确认", message: meaasge, preferredStyle:.alert)
            // 设置UIAlertAction
            callAction = UIAlertAction(title: "发短信", style: .default) { (UIAlertAction) in
                //自动打开发短信页面
                if !self.memberData.mobile!.isEmpty{
                    UIApplication.shared.open(URL(string :"sms://"+"\(self.memberData.mobile!)")!, options: [:], completionHandler: nil)
                }
            }
            break
        case 1:
            meaasge = String(format: "你确定要向%@打电话", memberData.mobile!)
            alertController = UIAlertController(title: "拨打确认", message: meaasge, preferredStyle:.alert)
            // 设置UIAlertAction
            callAction = UIAlertAction(title: "拨打", style: .default) { (UIAlertAction) in
                //自动打开拨号页面并自动拨打电话
                if !self.memberData.mobile!.isEmpty{
                    UIApplication.shared.open(URL(string :"tel://"+"\(self.memberData.mobile!)")!, options: [:], completionHandler: nil)
                }
            }
            break
        default:
            break
        }
        // 设置UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(callAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
    }
    func setData(data:MemberData){
        
        name.text = data.name
        subTitle.text = data.department
        phoneNum.text = data.mobile
        workMailbox.text = data.email
    }
    
}
