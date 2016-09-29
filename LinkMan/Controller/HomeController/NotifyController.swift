//
//  NotifyController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class NotifyController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSoure : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoData()
        
        let nib = UINib(nibName: "NotifyCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "notifyCell")
        self.tableView.separatorStyle = .none
    }

    func demoData(){
        
        let data1 =  NotifyData(n: "吴瑞豪", s: "sanp.png", t: "13:10", st: "1", ti: "申请请假批准", subTi: "ios部门")
        let data2 =  NotifyData(n: "陈华", s: "sanp.png", t: "10:10", st: "1", ti: "申请请假批准", subTi: "ios部门")
        let data3 =  NotifyData(n: "叶晨", s: "sanp.png", t: "13:10", st: "1", ti: "申请请假批准", subTi: "安卓部门")
        let data4 =  NotifyData(n: "程福兴", s: "sanp.png", t: "09:10", st: "1", ti: "申请请假批准", subTi: "PHP部门")
        
        dataSoure = NSMutableArray(objects: data1,data2,data3,data4)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backAction(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell") as! NotifyCell
        
        let data = dataSoure[(indexPath as NSIndexPath).row] as! NotifyData
        cell.setData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let applyleaveVC = ApplyleaveController()
        applyleaveVC.type = "待我审批"
        applyleaveVC.statusType = "2"
        applyleaveVC.leave_id = 2
        self.navigationController?.pushViewController(applyleaveVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
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
