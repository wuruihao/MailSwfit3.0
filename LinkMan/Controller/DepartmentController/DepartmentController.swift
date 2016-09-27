//
//  DepartmentController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class DepartmentController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var dataSoure : [DepartmentData]! = [DepartmentData]()
    var filteredArray : [DepartmentData]! = [DepartmentData]()
    var shouldShowSearchResults = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建一个重用的单元格
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //模拟数据
        demo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func demo(){
        
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.departmentRequest(token!, finishedSel: { (data:[DepartmentData]) in
            
            print("data\(data)")
            
            self.dataSoure = data
            self.tableView.reloadData()
            
            CoreDataTool.shared.addDepartmentsCoreData(data: data)
            
        }) { (error:ETError) in
            
            print("error\(error)")
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
    func numberOfSections(in tableView: UITableView) -> Int{
        
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
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
    }    /*
     
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
