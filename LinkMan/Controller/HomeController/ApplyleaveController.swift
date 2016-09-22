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
        NetworkTool.shareNetworkTool.leaveDetailsRequest(token!, id: leave_id, finishedSel: { (data:LeaveData) in
            
            self.leaveData = data
            self.nameLabel.text = data.name
            self.phoneLabel.text = data.mobile
            self.timeLabel.text = String(format: "%d天", data.time)
            self.startedLabel.text = data.started
            self.endedLabel.text = data.ended
            self.reasonLabel.text = data.reason
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
    
    func sendleaveRequest(status:Int){
        
        NetworkTool.shareNetworkTool.approvedLeaveRequest(token!, status: status, id: leave_id, finishedSel: { (data:ETSuccess) in
            
            self.navigationController?.popViewController(animated: true)
            
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
    
    @IBAction func backAction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        
        if type == "待我审批" {
            
            sendleaveRequest(status: sender.tag)
            
        }else{
            
            switch sender.tag {
            case 1:
                //调用删除接口
                NetworkTool.shareNetworkTool.deleteleaveRequest(token!, id: leave_id, finishedSel: { (data:ETSuccess) in
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    }, failedSel: { (error:ETError) in
                        let alertView = UIAlertView()
                        alertView.title = error.message!
                        alertView.show()
                        let time: TimeInterval = 1.0
                        let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
                            alertView.dismiss(withClickedButtonIndex: 0, animated: true)
                        }
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
