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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
       _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func finishedEdit(_ sender: UIButton) {
        
        
        
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
