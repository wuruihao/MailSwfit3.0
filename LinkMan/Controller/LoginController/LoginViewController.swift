//
//  LoginViewController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/7.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userName.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    //@IBAction func registerAction(_ sender: UIButton) {
        
       // print("注册事件")
   // }
    //@IBAction func cancelAction(_ sender: UIButton) {
        
      //  UIApplication.shared.keyWindow?.rootViewController = ETTabBarController()
   // }
    @IBAction func login(_ sender: UIButton) {
        
        if userName.text == nil {
            self.showHint("请输入手机号")
            userName.becomeFirstResponder()
            return
        }
        if password.text == nil {
            self.showHint("请输入密码")
            password.becomeFirstResponder()
            return
        }
        self.showHud(in: self.view, hint: messageLoading)
        NetworkTool.shareNetworkTool.loginRequest(userName.text!, password: password.text!, finishedSel: { (data:MemberData) in
            
            print("data:\(data)")
            self.hideHud()
            self.saveUserDefaults(data)
            UIApplication.shared.keyWindow?.rootViewController = ETTabBarController()
            UserDefaults.standard.set(true, forKey: YMFirstLaunch)
            
        }) { (error:ETError) in
            
            self.hideHud()
            self.showHint(error.message!)
            print("error:\(error)")
        }
    }
    
    func saveUserDefaults(_ data:MemberData){
        
        var defaults:UserDefaults!
        defaults = UserDefaults()
        defaults.set(data.id as Int, forKey: userID)
        defaults.set(data.sex as Int, forKey: userSex)

        if data.name != nil {
            defaults.set(data.name! as String, forKey: userRealName)
        }
        if data.mobile != nil {
            defaults.set(data.mobile! as String, forKey: userMobile)
        }
        if data.token != nil {
            defaults.set(data.token! as String, forKey: userToken)
        }
        if data.level != nil {
            defaults.set(data.level! as String, forKey: userLevel)
        }
        if data.head_img != nil {
            defaults.set(data.head_img! as String, forKey: userHeadImg)
        }
        if data.nickname != nil {
            defaults.set(data.nickname! as String, forKey: userNickname)
        }
        if data.department != nil {
            defaults.set(data.department! as String, forKey: userDepartment)
        }
        if data.email != nil {
            defaults.set(data.email! as String, forKey: userEmail)
        }
    }
}
