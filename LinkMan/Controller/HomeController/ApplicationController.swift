//
//  ApplicationController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class ApplicationController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var selectLine: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var dataSoure : [LeaveData]! = [LeaveData]()
    var dataArray : [LeaveData]! = [LeaveData]()
    var typeId : String!
    var selectedType :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedType = "1"
        demoData()
        let nib = UINib(nibName: "ApplicationCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
        
        let addBtn = UIButton(type: .custom)
        addBtn.width = kFitWidth(value: 120)
        addBtn.height = kFitWidth(value: 120)
        addBtn.x = kScreenWidth-addBtn.width-kFitWidth(value: 60)
        addBtn.y = kScreenHeight*0.85
        addBtn.setImage(UIImage(named: "addLeave.png"), for: UIControlState())
        addBtn.addTarget(self, action: #selector(ApplicationController.addApplyleave), for: .touchUpInside)
        self.view.addSubview(addBtn)
        
    }
    func addApplyleave(){
        self.navigationController?.pushViewController(EditApplyleaveController(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func demoData(){
        
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.applyleaveListRequest(token!, finishedSel: { (data:[LeaveData]) in
            self.dataSoure = data
            self.tableView.reloadData()
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
    func demoData2(){
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.examinedAndApprovedLeaveRequest(token!, finishedSel: { (data:[LeaveData]) in
            self.dataArray = data
            self.tableView.reloadData()
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
    @IBAction func selectType(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.selectLine.x = sender.frame.origin.x
            }, completion: nil)
        switch sender.tag {
        case 0:
            typeId = "1"
            selectedType = typeId
            //发送请求
            //newRequest()
            self.dataArray.removeAll()
            //模拟数据
            demoData()
            tableView.reloadData()
            break
        case 1:
            typeId = "2"
            selectedType = typeId
            self.dataSoure.removeAll()
            //模拟数据
            demoData2()
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    //网络请求
    func newRequest(){
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedType == "1" {
            return dataSoure.count
        }else if selectedType == "2" {
            return dataArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ApplicationCell
        
        let data = dataSoure[(indexPath as NSIndexPath).row] 
        cell.type = selectedType
        cell.setData(data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let applyleaveVC = ApplyleaveController()
        applyleaveVC.type = selectedType
        self.navigationController?.pushViewController(applyleaveVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}
