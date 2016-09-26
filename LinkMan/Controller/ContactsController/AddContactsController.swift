//
//  AddContactsController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class AddContactsController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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

    let imagePickerController: UIImagePickerController = UIImagePickerController()
    
    var departmentName: String! = String()
    var level: String! = String()
    
    var memberData: MemberData!
    var type: String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //registerKeyBoardShow(target: self)
        //registerKeyBoardHide(target: self)
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setEditData()
        
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editSanpInfo(_ sender: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "照相机", style: .default, handler: { (action:UIAlertAction) in
            self.openPhotoAction(type: .camera)
        }))
        alertController.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (action:UIAlertAction) in
            self.openPhotoAction(type: .photoLibrary)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler:nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func openPhotoAction(type: UIImagePickerControllerSourceType){
       
        // 判断是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(type){
            if type == .photoLibrary {
                // 设置类型
                imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //改navigationBar背景色
                imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
                //改navigationBar标题色
                imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                //改navigationBar的button字体色
                imagePickerController.navigationBar.tintColor = UIColor.white
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                // 设置类型
                imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }

        }else{
            // 创建
            let alertController = UIAlertController(title: "提示", message: "设备不支持此功能", preferredStyle:.alert)
            // 设置UIAlertAction
            let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            // 添加
            alertController.addAction(cancelAction)
            // 弹出
            self.present(alertController, animated: true, completion: nil)
            return
        }
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
        
        _ =  self.navigationController?.popViewController(animated: true)
        
    }
    
    func textResignFirstResponder(){
        
        nameTextField.resignFirstResponder()
        sexTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        workmMailbox.resignFirstResponder()
        companyTextField.resignFirstResponder()
    }
    
    @IBAction func sureSubmitServer(_ sender: UIButton) {
        
        if nameTextField.text == "" {
            self.showHint("请输入姓名")
            nameTextField.becomeFirstResponder()
            return
        }
        if phoneTextField.text == "" {
            self.showHint("请输入手机号码")
            phoneTextField.becomeFirstResponder()
            return
        }
        if workmMailbox.text == "" {
            self.showHint("请输入工作邮箱")
            workmMailbox.becomeFirstResponder()
            return
        }
        if departmentName == "" {
            textResignFirstResponder()
            self.showHint("请选择部门")
            return
        }
        if level == "" {
            textResignFirstResponder()
            self.showHint("请选择职位")
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
        if type == "编辑" {
            let id = String(format: "%d", memberData.id)
            
            let params = ["id": id,"token": token!,"mobile": phoneTextField.text!,"email": workmMailbox.text!,"department_id": description,"level_id": level,"head_img":"","nickname":nickNameTextField.text!,"name":nameTextField.text!]

            NetworkTool.shareNetworkTool.editContactsRequest(params as NSDictionary, finishedSel: { (data:ETSuccess) in
                
                 _ =  self.navigationController?.popToRootViewController(animated: true)
                
                }, failedSel: { (error:ETError) in
                    self.showHint(error.message!)
            })
        }else{
            NetworkTool.shareNetworkTool.addContactsRequest(nameTextField.text!,token:token!,mobile: phoneTextField.text!,email: workmMailbox.text!, departmentName: departmentName, level: level,password:companyTextField.text!, finishedSel: { (success:ETSuccess) in
                _ =  self.navigationController?.popViewController(animated: true)
                
            }) { (error:ETError) in
                self.showHint(error.message!)
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
    
    
    //注册键盘出现
    func registerKeyBoardShow(target: UIViewController) {
        
        NotificationCenter.default.addObserver(target, selector: #selector(AddContactsController.keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // 注册键盘隐藏
    func registerKeyBoardHide(target: UIViewController) {
        NotificationCenter.default.addObserver(target, selector: #selector(AddContactsController.keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 移除键盘出现通知
    func removeKeyboardNotifications(target: UIViewController) {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // 移除键盘隐藏通知
    func removeKeyboardHideNotifications(target: UIViewController) {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 返回键盘高度
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    // 返回键盘上拉动画持续时间
    func getKeyBoardDuration(notification: NSNotification) -> Double {
        let userInfo = notification.userInfo
        let keyboardDuration = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        return keyboardDuration
    }
    
    // 返回键盘动画曲线
    func getKeyBoardAnimationCurve(notification: NSNotification) -> NSObject {
        let userInfo = notification.userInfo
        let keyboardTranstionAnimationCurve = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSValue
        
        return keyboardTranstionAnimationCurve
    }
    func keyboardWillShowNotification(notification:NSNotification){
        
        let rect = getKeyboardHeight(notification: notification)
        
        self.view.y = -rect
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        self.view.y = 0
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
