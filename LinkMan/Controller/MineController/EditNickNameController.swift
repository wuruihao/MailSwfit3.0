//
//  EditNickNameController.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/18.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class EditNickNameController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var textField: UITextField!
    
    var type :String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        var text:String! = nil
        switch type {
        case "昵称":
            text = UserDefaults().object(forKey: userNickname) as! String!
            break
        case "手机":
            //text = UserDefaults().object(forKey: userMobile) as! String!
            break
        case "邮箱":
            text = UserDefaults().object(forKey: userEmail) as! String!
            break
        default:
            break
        }
        if text != nil {
            textField.text = text
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishedEdit(_ sender: UIButton) {
        
        let token = UserDefaults().object(forKey: userToken) as! String!
        let params = ["token": token,"nickname":textField.text!]
        NetworkTool.shareNetworkTool.editMyInfoRequest(params as! [String : String], finishedSel: { (data:ETSuccess) in

            UserDefaults().set(self.textField.text! as String, forKey: userNickname)
            _ = self.navigationController?.popViewController(animated: true)
            
        }) { (error:ETError) in
            self.hideHud()
            self.showHint(error.message!)
            print("error:\(error)")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        let length = textField.text!.characters.count
        if length >= 20 {
            return false
        }
        return true
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
