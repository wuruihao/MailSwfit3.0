//
//  AddContactsController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class AddContactsController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var workmMailbox: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var sanpImage: UIImageView!
    @IBOutlet var itemArray: [UIButton]!
    @IBOutlet var levelItems: [UIButton]!
    
    @IBOutlet weak var naviItem: UINavigationItem!
    var departmentName: String!
    var level: String!
    
    var memberData: MemberData!
    var type: String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setEditData()
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    func setEditData(){
        if type == "编辑" {
            naviItem.title = "编辑联系人"
            nameTextField.text = memberData.name
            phoneTextField.text = memberData.mobile
            workmMailbox.text = memberData.email
            nickNameTextField.text = memberData.nickname
            sexTextField.text = memberData.sex
            for item in itemArray {
                
                if item.tag == memberData.department_id {
                    item.isSelected = true
                }else{
                    item.isSelected = false
                }
                if item.isSelected == true {
                    departmentName = String(format: "%d", item.tag)
                }
            }
            
            for item in levelItems {
                let index = String(format: "%d", item.tag)
                if index == memberData.level_id {
                    item.isSelected = true
                }else{
                    item.isSelected = false
                }
                if item.isSelected == true {
                    level = String(format: "%d", item.tag)
                }
            }
        }else{
            naviItem.title = "新增联系人"
        }
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func sureSubmitServer(_ sender: UIButton) {
        
        let alertView = UIAlertView()
        
        if nameTextField.text == "" {
            alertView.title = "请输入姓名"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            nameTextField.becomeFirstResponder()
            return
        }
        if departmentName == "" {
            alertView.title = "请选择部门"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            return
        }
        if level == "" {
            alertView.title = "请选择职位"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            return
        }
        if phoneTextField.text == "" {
            alertView.title = "请输入手机号码"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            phoneTextField.becomeFirstResponder()
            return
        }
        if workmMailbox.text == "" {
            alertView.title = "请输入工作邮箱"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            workmMailbox.becomeFirstResponder()
            return
        }
        
        /*
        if companyTextField.text == "" {
            alertView.title = "请输入账号密码"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            companyTextField.becomeFirstResponder()
            return
        }
        */
        let token = UserDefaults().object(forKey: userToken) as! String!
        let id = String(format: "%d", memberData.id)
        if type == "编辑" {
            NetworkTool.shareNetworkTool.editContactsRequest(id, token: token!, mobile: phoneTextField.text!, email: workmMailbox.text!, departmentName: description, level: level, headImg: "", nickname: nickNameTextField.text!, name: nameTextField.text!, finishedSel: { (data:ETSuccess) in
                
                self.navigationController?.popToRootViewController(animated: true)
                
                }, failedSel: { (error:ETError) in
                    
                    let alertView = UIAlertView()
                    alertView.title = error.message!
                    alertView.show()
                    let time: TimeInterval = 1.0
                    let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                        alertView.dismiss(withClickedButtonIndex: 0, animated: true)
                    }
            })
            
        }else{
            
            NetworkTool.shareNetworkTool.addContactsRequest(nameTextField.text!,token:token!,mobile: phoneTextField.text!,email: workmMailbox.text!, departmentName: departmentName, level: level,password:companyTextField.text!, finishedSel: { (success:ETSuccess) in
                
                self.navigationController?.popViewController(animated: true)
                
            }) { (error:ETError) in
                
                let alertView = UIAlertView()
                alertView.title = error.message!
                alertView.show()
                let time: TimeInterval = 1.0
                let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                    alertView.dismiss(withClickedButtonIndex: 0, animated: true)
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func selectDepartmentWithTypes(_ sender: UIButton) {
        
        for item in itemArray {
            if sender == item {
                item.isSelected = true
            }else{
                item.isSelected = false
            }
            if item.isSelected == true {
                
                departmentName = String(format: "%d", item.tag)
            }
        }
        
        
    }
    
    @IBAction func selectLevelWithTypes(_ sender: UIButton) {
        
        for item in levelItems {
            if sender == item {
                item.isSelected = true
            }else{
                item.isSelected = false
            }
            if item.isSelected == true {
                
                level = String(format: "%d", item.tag)
            }
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
