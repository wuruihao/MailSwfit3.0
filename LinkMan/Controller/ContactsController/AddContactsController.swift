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
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var workmMailbox: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var sanpImage: UIImageView!
    @IBOutlet var itemArray: [UIButton]!
    @IBOutlet var levelItems: [UIButton]!
    
    var departmentName: String!
    var level: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
            departmentTextField.becomeFirstResponder()
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
            positionTextField.becomeFirstResponder()
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
        let token = UserDefaults().object(forKey: userToken) as! String!
        
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
