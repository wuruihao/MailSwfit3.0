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
    
    
    var dataSoure : NSMutableArray!
    var dataArray : NSMutableArray!
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
        //未处理:0 被驳回:1 已批准:2 待我审批:3 已驳回:4 已审批:5
        let data1 =  ApplicationData(n: "吴瑞豪", s: "chat.png", t: "13:10", st: "0", ti: "请假申请:3天", subTi: "ios部门")
        let data2 =  ApplicationData(n: "陈华", s: "chat.png", t: "10:10", st: "2", ti: "请假申请:1天", subTi: "ios部门")
        let data3 =  ApplicationData(n: "叶晨", s: "chat.png", t: "13:10", st: "0", ti: "请假申请:2.5天", subTi: "安卓部门")
        let data4 =  ApplicationData(n: "程福兴", s: "chat.png", t: "09:10", st: "1", ti: "请假申请:3天", subTi: "PHP部门")
        
        dataSoure = NSMutableArray(objects: data1,data2,data3,data4)
            }

    func demoData2(){
        //未处理:0 被驳回:1 已批准:2 待我审批:3 已驳回:4 已审批:5
        let data1 =  ApplicationData(n: "陈华", s: "chat.png", t: "13:10", st: "3", ti: "请假申请:3天", subTi: "ios部门")
        let data2 =  ApplicationData(n: "吴瑞豪", s: "chat.png", t: "10:10", st: "4", ti: "请假申请:1天", subTi: "ios部门")
        let data3 =  ApplicationData(n: "程福兴", s: "chat.png", t: "13:10", st: "5", ti: "请假申请:2.5天", subTi: "安卓部门")
        let data4 =  ApplicationData(n: "叶晨", s: "chat.png", t: "09:10", st: "3", ti: "请假申请:3天", subTi: "PHP部门")
        
        dataSoure = NSMutableArray(objects: data1,data2,data3,data4)
        
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.selectLine.x = sender.frame.origin.x
            }, completion: nil)
        
        switch sender.tag {
        case 0:
            typeId = "1"
            selectedType = typeId
            dataSoure.removeAllObjects()
            //发送请求
            //newRequest()
            //模拟数据
            demoData()
            tableView.reloadData()
            break
        case 1:
            typeId = "2"
            selectedType = typeId
            dataSoure.removeAllObjects()
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
        /*
        if selectedType == "1" {
            return dataSoure.count
        }else if selectedType == "2" {
            return dataArray.count
        }
 */
        return dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ApplicationCell
        
        let data = dataSoure[(indexPath as NSIndexPath).row] as! ApplicationData
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
