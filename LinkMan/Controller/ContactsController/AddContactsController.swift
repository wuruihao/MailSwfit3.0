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
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var workmMailbox: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sanpImage: UIImageView!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet var sexItems: [UIButton]!
    @IBOutlet var itemArray: [UIButton]!
    @IBOutlet var levelItems: [UIButton]!
    @IBOutlet weak var naviItem: UINavigationItem!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    
    var memberData: MemberData!
    var departmentName: String! = String()
    var level: String! = String()
    var sexName: String! = String()
    var type: String!
    var sanpurl: String!
    var token: String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //registerKeyBoardShow(target: self)
        //registerKeyBoardHide(target: self)
        
        token = UserDefaults().object(forKey: userToken) as! String!
        
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setEditData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideHud()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 编辑头像
    ///
    /// - parameter sender:
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
    
    /// 返回
    ///
    /// - parameter sender:
    @IBAction func backAction(_ sender: AnyObject) {
        
        
        // 创建
        let alertController = UIAlertController(title: nil, message:"你确定放弃此次编辑?", preferredStyle:.alert)
        // 设置UIAlertAction
        let cancelAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            _ =  self.navigationController?.popViewController(animated: true)
        }
        let defaulAction = UIAlertAction(title: "取消", style: .cancel, handler:nil)
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(defaulAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 初始化编辑信息
    func setEditData(){
        
        if type == "编辑" {
            
            naviItem.title = "编辑联系人"
            sanpurl = memberData.head_img
            nameTextField.text = memberData.name
            phoneTextField.text = memberData.mobile
            workmMailbox.text = memberData.email
            nickNameTextField.text = memberData.nickname
            if memberData.head_img != nil {
                self.sanpImage.sd_setImage(with: URL.init(string: memberData.head_img!), placeholderImage: UIImage(named: "sanp.png"))
            }else{
                self.sanpImage.image = UIImage(named: "sanp.png")
            }
            passLabel.isHidden = true
            passwordTextField.isHidden = true
            for item in sexItems {
                if item.tag == memberData.sex {
                    item.isSelected = true
                }else{
                    item.isSelected = false
                }
                if item.isSelected == true {
                    sexName = String(format: "%d", item.tag)
                }
            }
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
            
            deleteButton.isHidden = false
            
        }else{
            naviItem.title = "新增联系人"
            passLabel.isHidden = false
            passwordTextField.isHidden = false
            deleteButton.isHidden = true
        }
    }
    
    /// textField隐藏
    func textResignFirstResponder(){
        
        nameTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        workmMailbox.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    /// 提交编辑或添加联系人请求
    ///
    /// - parameter sender:
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
        if type != "编辑" {
            if passwordTextField.text == "" {
                self.showHint("请输入账号密码")
                passwordTextField.becomeFirstResponder()
                return
            }
        }
        sendRequest()
        
    }
    
    @IBAction func deleteContacts(_ sender: UIButton) {
        
        // 创建
        let alertController = UIAlertController(title: nil, message:"你确定删除此联系人?", preferredStyle:.alert)
        // 设置UIAlertAction
        let cancelAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            self.deleteContactsRequest()
            _ =  self.navigationController?.popToRootViewController(animated: true)
        }
        let defaulAction = UIAlertAction(title: "取消", style: .cancel, handler:nil)
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(defaulAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
    }
    //删除
    func deleteContactsRequest(){
        self.showHud(in: self.view, hint: messageLogin)
        let userId = String(format: "%d", memberData.id)
        NetworkTool.shareNetworkTool.deleteFriendsContactsRequest(token!, id: userId, finishedSel: { (data:ETSuccess) in
            self.hideHud()
        }) { (error:ETError) in
            self.hideHud()
            self.showHint(error.message!)
        }
    }
    //请求
    func sendRequest(){
        
        if type == "编辑" {
            //编辑
            let userId = String(format: "%d", memberData.id)
            let params = ["id": userId,"token": token!,"mobile": phoneTextField.text!,"email": workmMailbox.text!,"department_id":  departmentName,"level_id": level,"nickname":nickNameTextField.text!,"name":nameTextField.text!,"uri":sanpurl,"sex":sexName!]
            self.showHud(in: self.view, hint: messageLogin)
            NetworkTool.shareNetworkTool.editContactsRequest(params as! [String:String], finishedSel: { (data:ETSuccess) in
                self.hideHud()
                _ =  self.navigationController?.popToRootViewController(animated: true)
                
                }, failedSel: { (error:ETError) in
                    self.hideHud()
                    self.showHint(error.message!)
            })
        }else{
            //添加
            self.showHud(in: self.view, hint: messageLogin)
            if sanpurl == nil {
                sanpurl = ""
            }
            let params = ["token": token!,"mobile": phoneTextField.text!,"email": workmMailbox.text!,"department_id":  departmentName!,"level_id": level!,"nickname":nickNameTextField.text!,"name":nameTextField.text!,"uri":sanpurl!,"sex":sexName!,"password":passwordTextField.text!]
            
            NetworkTool.shareNetworkTool.addContactsRequest(params, finishedSel: { (data:ETSuccess) in
                
                self.hideHud()
                _ =  self.navigationController?.popViewController(animated: true)
                
            }) { (error:ETError) in
                self.hideHud()
                self.showHint(error.message!)
            }
        }
    }
    
    /// 点击空白隐藏键盘
    ///
    /// - parameter touches:
    /// - parameter event:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    @IBAction func selectSexWithTypes(_ sender: UIButton) {
        
        for item in sexItems {
            if sender == item {
                item.isSelected = true
            }else{
                item.isSelected = false
            }
            if item.isSelected == true {
                sexName = String(format: "%d", item.tag)
            }
        }
        
    }
    
    /// 选择部门
    ///
    /// - parameter sender:
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
    
    /// 选择职位
    ///
    /// - parameter sender:
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
    
    /// 打开相机或相册
    ///
    /// - parameter type:
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
    //实现ImagePicker delegate 事件
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        /* 此处info 有六个值
         * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
         * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
         * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
         * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
         * UIImagePickerControllerMediaURL;       // an NSURL
         * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
         * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
         */
        //在这里调用网络通讯方法，上传头像至服务器...
        
        let images = NSArray(objects: image,"jpeg")
        let uploads = NSMutableArray()
        uploads.add(images)
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.postImageRequest(uploads, token: token!, finishedSel: { (data:[ImageData]) in
            self.hideHud()
            let imageData = data[0]
            if imageData.uri != nil {
                self.sanpurl = imageData.uri
                self.sanpImage.sd_setImage(with: URL.init(string: imageData.url!), placeholderImage: UIImage(named: "sanp.png"))
            }
            
        }) { (error:ETError) in
            
            self.hideHud()
            self.showHint(error.message!)
            print("error:\(error)")
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        self.dismiss(animated: true, completion: nil)
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
