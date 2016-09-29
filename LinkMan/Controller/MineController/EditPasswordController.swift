//
//  EditPasswordController.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/28.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class EditPasswordController: UIViewController {
    
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var oldTextField: UITextField!
    @IBOutlet weak var newTextField: UITextField!
    @IBOutlet weak var sameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editPasswordAction(_ sender: UIButton) {
        
        if oldTextField.text == "" {
            self.showHint("请输入原始密码!")
            return
        }
        if newTextField.text == "" {
            self.showHint("密码不能为空!")
            return
        }
        if sameTextField.text == "" {
            self.showHint("请确认密码！")
            return
        }
        if oldTextField.text == "" {
            self.showHint("请输入原始密码!")
            return
        }
        if newTextField.text != sameTextField.text {
            self.showHint("两次输入密码不一致，请重新输入！")
            return
        }
        let token = UserDefaults().object(forKey: userToken) as! String!
        let params = ["token": token!,"old_password": oldTextField.text!,"new_password":newTextField.text!]
        
        NetworkTool.shareNetworkTool.editPasswordRequest(params, finishedSel: { (data:ETSuccess) in
            
             _ = self.navigationController?.popViewController(animated: true)
            
        }) { (error:ETError) in
            self.hideHud()
            self.showHint(error.message!)
            print("error:\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
