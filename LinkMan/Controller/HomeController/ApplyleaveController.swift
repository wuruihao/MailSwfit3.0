//
//  ApplyleaveController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/12.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class ApplyleaveController: UIViewController {
    
    @IBOutlet weak var naviItem: UINavigationItem!
    @IBOutlet weak var mainView: UIScrollView!
    
    var leave_id: Int!
    var type: String!
    var token:String!
    var statusType: String!
    var leaveData:LeaveData!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var endedLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var actionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = UserDefaults().object(forKey: userToken) as! String!
    }
    override func viewWillAppear(_ animated: Bool) {
        
        switch statusType {
        //未审批
        case "1":
            if type == "待我审批" {
                self.cancelButton.setTitle("驳回", for: .normal)
                self.connectButton.setTitle("同意批准", for: .normal)
            }else{
                self.cancelButton.setTitle("删除", for: .normal)
                self.connectButton.setTitle("再次编辑", for: .normal)
            }
            break
        //已通过
        case "2":
            self.actionView.isHidden = true
            break
        //未通过
        case "3":
            if type == "待我审批" {
                self.actionView.isHidden = true
            }else{
                self.actionView.isHidden = false
                self.cancelButton.setTitle("删除", for: .normal)
                self.connectButton.setTitle("再次编辑", for: .normal)
            }
            break
        case "4":
            if type == "待我审批" {
                self.actionView.isHidden = true
            }else{
                self.actionView.isHidden = false
                self.cancelButton.setTitle("删除", for: .normal)
                self.connectButton.setTitle("再次编辑", for: .normal)
            }
            break
        default:
            break
        }
        if type == "待我审批" {
            self.naviItem.title = "请假审批"
        }else{
            self.naviItem.title = "请假申请"
        }
        sendRequest()
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func sendRequest(){
        
        self.showHud(in: self.view, hint: messageLogin)
        
        NetworkTool.shareNetworkTool.leaveDetailsRequest(token!, id: leave_id, finishedSel: { (data:LeaveData) in
            
            self.hideHud()
            
            self.leaveData = data
            self.nameLabel.text = data.name
            self.phoneLabel.text = data.mobile
            self.timeLabel.text = String(format: "%d天", data.time)
            if data.created != " " || data.created != nil || data.created != "nil" || !(data.created?.isEmpty)!{
                let array = data.started?.components(separatedBy: " ")
                self.startedLabel.text = array?[0]
            }
            if data.created != " " || data.created != nil || data.created != "nil" || !(data.created?.isEmpty)!{
                let array = data.ended?.components(separatedBy: " ")
                self.endedLabel.text = array?[0]
            }
            self.reasonLabel.text = data.reason
            if data.created != " " || data.created != nil || data.created != "nil" || !(data.created?.isEmpty)!{
                
                let array = data.created?.components(separatedBy: " ")
                let strArray = array?[0].components(separatedBy: "-")
                let created = String(format: "%@月%@日", (strArray?[1])!,(strArray?[2])!)
                self.createdLabel.text = created
            }
            
            
            //未处理:0 被驳回:1 已批准:2 待我审批:3 已驳回:4 已审批:5
            switch data.status! as String{
            case "1":
                self.statusLabel.text = "未审批"
                self.statusLabel.textColor = RGBA(r: 122.0, g: 193.0, b: 229.0, a: 1.0)
                break
            case "2":
                self.statusLabel.text = "已通过"
                self.statusLabel.textColor = RGBA(r: 140.0, g: 140.0, b: 140.0, a: 1.0)
                break
            case "3":
                self.statusLabel.text = "未通过"
                self.statusLabel.textColor = UIColor.red
                break
            case "4":
                self.statusLabel.text = "已销毁"
                self.statusLabel.textColor = RGBA(r: 140.0, g: 140.0, b: 140.0, a: 1.0)
                break
            default:
                break
            }
            
        }) { (error:ETError) in
            
            self.hideHud()
            self.showHint(error.message!)
        }
    }
    
    func sendleaveRequest(status:Int){
        
        self.showHud(in: self.view, hint: messageLogin)
        
        NetworkTool.shareNetworkTool.approvedLeaveRequest(token!, status: status, id: leave_id, finishedSel: { (data:ETSuccess) in
            
            self.hideHud()
            
             _ = self.navigationController?.popViewController(animated: true)
            
        }) { (error:ETError) in
            
            self.hideHud()
            self.showHint(error.message!)
        }
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        
        if type == "待我审批" {
            
            sendleaveRequest(status: sender.tag)
            
        }else{
            
            switch sender.tag {
            case 1:
                //调用删除接口
                NetworkTool.shareNetworkTool.deleteleaveRequest(token!, id: leave_id, finishedSel: { (data:ETSuccess) in

                     _ = self.navigationController?.popViewController(animated: true)
                    
                    }, failedSel: { (error:ETError) in
                        self.showHint(error.message!)
                })
                break
            case 2:
                
                let editApplyleaveVC =  EditApplyleaveController()
                editApplyleaveVC.leaveData = leaveData
                editApplyleaveVC.type = "再次编辑"
                self.navigationController?.pushViewController(editApplyleaveVC, animated: true)
                
                break
            default:
                break
            }
        }
    }
    /*
     // MARK: - Navigation     // In a storyboard-based application, you will often want to do a little preparation before navigat
     
     ion
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
