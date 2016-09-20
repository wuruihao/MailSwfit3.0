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
    @IBAction func registerAction(_ sender: UIButton) {
        
        print("注册事件")
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        
        UIApplication.shared.keyWindow?.rootViewController = ETTabBarController()
    }
    @IBAction func login(_ sender: UIButton) {
        
        let alertView = UIAlertView()
        
        if userName.text == nil {
            alertView.title = "请输入手机号"
            alertView.show()
            
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            userName.becomeFirstResponder()
            return
        }
        if password.text == nil {
            alertView.title = "请输入密码"
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            password.becomeFirstResponder()
            return
        }
        
        NetworkTool.shareNetworkTool.loginRequest(userName.text!, password: password.text!, finishedSel: { (data:MemberData) in
            
            print("data:\(data)")
            
            self.saveUserDefaults(data)
            
            UIApplication.shared.keyWindow?.rootViewController = ETTabBarController()
            
            
        }) { (error:ETError) in
            
            alertView.title = error.message!
            alertView.show()
            let time: TimeInterval = 1.0
            let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                alertView.dismiss(withClickedButtonIndex: 0, animated: true)
            }
            
            print("error:\(error)")
        }
    }
    
    
    func saveUserDefaults(_ data:MemberData){
        
        var defaults:UserDefaults!
        defaults = UserDefaults()
        if data.id != nil {
            defaults.set(data.id! as Int, forKey: userID)
        }
        if data.sex != nil {
            defaults.set(data.sex! as String, forKey: userSex)
        }
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
    }
}
