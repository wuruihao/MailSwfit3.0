//
//  ApplicationController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class ApplicationController: UIViewController ,UITableViewDataSource, UITableViewDelegate, SelectIndexPathDelegate{
    
    @IBOutlet weak var selectLine: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var dataSoure : [LeaveData]! = [LeaveData]()
    var dataArray : [LeaveData]! = [LeaveData]()
    var type : String!
    var selectedType :String!
    var popView :XTPopView!
    
    @IBOutlet weak var sortButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedType = "我提交的"
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
       let editVC =  EditApplyleaveController()
        editVC.type = "添加请假"
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
        if selectedType == "我提交的" {
            sendMyleaveListRequest(status: 0, isMust: false)
        }else if selectedType == "待我审批" {
            sendApprovedLeaveListRequest(status: 0, isMust: false)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func sendMyleaveListRequest(status:Int, isMust:Bool){
        
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.applyleaveListRequest(token!, status: status, isMust: isMust, finishedSel: { (data:[LeaveData]) in

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
    func sendApprovedLeaveListRequest(status:Int, isMust:Bool){
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.examinedAndApprovedLeaveRequest(token!, status: status, isMust: isMust, finishedSel: { (data:[LeaveData]) in

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
            type = "我提交的"
            selectedType = type
            //发送请求
            //newRequest()
            self.dataArray.removeAll()
            //模拟数据
            sendMyleaveListRequest(status: 0, isMust: false)
            tableView.reloadData()
            break
        case 1:
            type = "待我审批"
            selectedType = type
            self.dataSoure.removeAll()
            //模拟数据
            sendApprovedLeaveListRequest(status: 0, isMust: false)
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectedSortList(_ sender: UIButton) {
        
        let point = CGPoint(x: sortButton.centerX-kFitWidth(value: 20), y: sortButton.y+sortButton.height)
        
        popView = XTPopView(origin: point, width: kFitWidth(value: 200), height: kFitHeight(value: 120)*4, type: .typeOfUpRight, color: RGBA(r: 0.2737, g: 0.2737, b: 0.2737, a: 1.0))
        popView.dataArray = ["未审批","已通过","未通过","销假单"]
        popView.fontSize = 14*kScreenHeight/667
        popView.row_height = kFitHeight(value: 120)
        popView.titleTextColor = UIColor.white
        popView.delegate = self
        popView.popView()
    }
    
    func selectIndexPathRow(_ index: Int) {

        if selectedType == "我提交的" {
            sendMyleaveListRequest(status: index+1, isMust: true)
        }else if selectedType == "待我审批" {
            sendApprovedLeaveListRequest(status: index+1, isMust: true)
        }

        popView.dismiss()
    }
    
    //网络请求
    func newRequest(){
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedType == "我提交的" {
            return dataSoure.count
        }else if selectedType == "待我审批" {
            return dataArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ApplicationCell
        var data:LeaveData = LeaveData()
        if selectedType == "我提交的" {
            data = dataSoure[(indexPath as NSIndexPath).row]
        }else if selectedType == "待我审批" {
            data = dataArray[(indexPath as NSIndexPath).row]
        }
        cell.type = selectedType
        cell.setData(data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data:LeaveData = LeaveData()
        if selectedType == "我提交的" {
            data = dataSoure[(indexPath as NSIndexPath).row]
        }else if selectedType == "待我审批" {
            data = dataArray[(indexPath as NSIndexPath).row]
        }
        let applyleaveVC = ApplyleaveController()
        applyleaveVC.type = selectedType
        applyleaveVC.statusType = data.status
        applyleaveVC.leave_id = data.id
        self.navigationController?.pushViewController(applyleaveVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}
