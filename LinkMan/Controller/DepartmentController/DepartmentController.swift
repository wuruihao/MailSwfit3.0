//
//  DepartmentController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import AFNetworking

class DepartmentController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var timer:Timer!
    var token :String!
    
    var dataSoure : [DepartmentData]! = [DepartmentData]()
    var filteredArray : [DepartmentData]! = [DepartmentData]()
    var shouldShowSearchResults = false

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = UserDefaults().object(forKey: userToken) as! String!
        
        //创建一个重用的单元格
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        networkStatusListener()
        NotificationCenter.default.addObserver(self, selector: #selector(DepartmentController.textFieldDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.hideHud()
        if timer != nil {
            timer.invalidate()
        }
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        removeNotificationCenter()
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func networkStatusListener() {
        
        // 1、设置网络状态消息监听
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChange), name: NSNotification.Name.AFNetworkingReachabilityDidChange, object: nil);
        // 2、获得网络Reachability对象
        // Reachability必须一直存在，所以需要设置为全局变量
        // 3、开启网络状态消息监听
        AFNetworkReachabilityManager.shared().startMonitoring()
    }
    
    func networkStatusChange() {
        
        if AFNetworkReachabilityManager.shared().isReachable { // 判断网络连接状态
            print("网络连接：可用")
            if AFNetworkReachabilityManager.shared().isReachableViaWiFi { // 判断网络连接类型
                print("连接类型：WiFi")
            } else if AFNetworkReachabilityManager.shared().isReachableViaWWAN {
                print("连接类型：移动网络")
            }
            self.showHud(in: self.view, hint: messageLogin)
            let params = ["token":token!]
            sendDepartmentRequest(params: params)
        }else{
            print("网络连接：不可用")
            print("连接类型：没有网络连接")
            
            self.showHint("当前网络不可用")
            
            let array = CoreDataTool.shared.printAllDataWithCoreData()
            let dep = array.mutableCopy() as! [DepartmentData]
            self.dataSoure = dep
            self.tableView.reloadData()
        }
    }
    
    /**
     移除消息通知
     */
    func removeNotificationCenter(){
        
        print("移除消息通知")
        // 关闭网络状态消息监听
        AFNetworkReachabilityManager.shared().stopMonitoring()
        // 移除网络状态消息通知
        NotificationCenter.default.removeObserver(self);
    }
    
    func sendDepartmentRequest(params: [String:String]){
        
        NetworkTool.shareNetworkTool.departmentRequest(params, finishedSel: { (data:[DepartmentData]) in
            
            print("data\(data)")
            self.hideHud()
            if self.shouldShowSearchResults {
                
                self.filteredArray = data
            }else {
                self.dataSoure = data
                CoreDataTool.shared.addDepartmentsCoreData(data: data)
            }
            self.tableView.reloadData()
            
        }) { (error:ETError) in
            
            print("error\(error)")
            self.hideHud()
            let array = CoreDataTool.shared.printAllDataWithCoreData()
            let dep = array.mutableCopy() as! [DepartmentData]
            self.dataSoure = dep
            self.tableView.reloadData()
        }
        
        
        /*
         let array = CoreDataTool.shared.printAllDataWithCoreData()
         let dep = array.mutableCopy() as! [DepartmentData]
         self.dataSoure = dep
         self.tableView.reloadData()
         */
    }
    
    @IBAction func addContacts(_ sender: UIButton) {
        
        let addContactsVC = AddContactsController()
        addContactsVC.type = "添加"
        addContactsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addContactsVC, animated: true)
    }
    
    @IBAction func cancelBtnClick(_ sender: AnyObject) {
        
        self.textResignFirstResponder()
    }
    
    func textResignFirstResponder(){
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        self.filteredArray.removeAll()
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        
        self.textResignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func timerTextDidChange(){
        
        let params = ["token":token!,"name":searchTextField.text!]
        sendDepartmentRequest(params: params)
    }
    
    func addTimerSearch(){
        
        if searchTextField.text != ""{
            shouldShowSearchResults = true
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(DepartmentController.timerTextDidChange), userInfo: nil, repeats:false)
            timer.fire()
        }else{
            self.textResignFirstResponder()
        }
    }
    
    @objc private func textFieldDidChange(notification:Notification){
        
        self.addTimerSearch()
    }
    
    // tableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int{
        
        if shouldShowSearchResults {
            return filteredArray.count
        }else {
            return dataSoure.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if shouldShowSearchResults {
            let department = filteredArray[section]
            return department.members!.count
        }
        else {
            let department = dataSoure[section]
            return department.members!.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ContactsCell
        var department:DepartmentData
        if shouldShowSearchResults {
            department = filteredArray[(indexPath as NSIndexPath).section]
        }else{
            department = dataSoure[(indexPath as NSIndexPath).section]
        }
        let data = department.members?[(indexPath as NSIndexPath).row] as! MemberData
        cell.setData(data: data)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenHeight*0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        var department:DepartmentData
        if shouldShowSearchResults {
            department = filteredArray[(indexPath as NSIndexPath).section]
        }else{
            department = dataSoure[(indexPath as NSIndexPath).section]
        }
        let data = department.members?[(indexPath as NSIndexPath).row] as! MemberData
        
        let staffInformationVC = StaffInformationController()
        staffInformationVC.memberData = data
        staffInformationVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(staffInformationVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var department:DepartmentData
        if shouldShowSearchResults {
            department = self.filteredArray[section]
            
        }else{
            department = self.dataSoure[section]
        }
        if department.number == "0" {
            return 0.1
        }
        
        return kScreenHeight*0.05
    }
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView:UITableView, titleForHeaderInSection
        section:Int)->String?{
        var department:DepartmentData
        if shouldShowSearchResults {
            department = self.filteredArray[section]
        }else{
            department = self.dataSoure[section]
        }
        if department.number == "0" {
            return ""
        }
        return department.name
    }
    //设置分组尾部高度（不需要尾部，设0.0好像无效）
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,y: 0,width: kScreenWidth,height: kScreenHeight*0.05))
        view.backgroundColor = RGBA(r: 242.0, g: 242.0, b: 242.0, a: 1.0)
        let label = UILabel(frame: CGRect(x: kScreenWidth*0.05,y: 0, width: view.width,height: kScreenHeight*0.05))
        label.textColor = RGBA(r: 111.0, g: 116.0, b: 118.0, a: 1.0)
        label.text = self .tableView(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        return view
    }
}
