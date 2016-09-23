//
//  EditApplyleaveController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/12.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class EditApplyleaveController: UIViewController {
    
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var beginDay: UILabel!
    @IBOutlet weak var leaveDay: UILabel!
    @IBOutlet weak var leaveType: UILabel!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var naviItem: UINavigationItem!
    
    var backView: UIView!
    var datePicker: UIDatePicker!
    var fromDate: Date! = Date()
    var toDate: Date! = Date()
    var leaveData:LeaveData!
    var type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if type == "再次编辑" {
            
            leaveDay.text = String(format: "%d", leaveData.time)
            
            if leaveData.started != "" {
                let array = leaveData.started?.components(separatedBy: " ")
                beginDay.text = array?[0]
            }
            if leaveData.ended != "" {
                let array = leaveData.ended?.components(separatedBy: " ")
               endDay.text = array?[0]
            }
            
            reasonTextView.text = leaveData.reason
            naviItem.title = "编辑请假信息"
        }else{
            naviItem.title = "添加请假信息"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func addDatePicker(_ tag:NSInteger){
        
        backView = UIView(frame: self.view.frame)
        backView.backgroundColor = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 0.5)
        UIApplication.shared.delegate?.window!!.addSubview(backView)
        
        //注册tap手势事件
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditApplyleaveController.handleTap(_:)))
        backView.addGestureRecognizer(tapRecognizer)
        
        //创建日期选择器
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth,height: kScreenHeight*0.3))
        datePicker.tag = tag
        datePicker.backgroundColor = UIColor.white
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(EditApplyleaveController.dateChanged(_:)),for: UIControlEvents.valueChanged)
        
        UIApplication.shared.delegate?.window!!.addSubview(datePicker)
    }
    
    //日期选择器响应方法
    func dateChanged(_ datePicker : UIDatePicker){
       
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: datePicker.date))
        print("datePicker.date\(datePicker.date)")
        
        
        if datePicker.tag == 1 {
            fromDate = datePicker.date
            beginDay.text = formatter.string(from: datePicker.date)
            
        }else if datePicker.tag == 2 {
            toDate = datePicker.date
            endDay.text = formatter.string(from: datePicker.date)
        }
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let r = gregorian!.components(NSCalendar.Unit.day, from: fromDate, to: toDate, options: NSCalendar.Options.init(rawValue: 0))
        
        if r.day! < 0 {
            self.leaveDay.text = "0"
        }else{
            self.leaveDay.text = String(format: "%d", r.day!)
        }
        
    }
    
    func handleTap(_ sender:UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.datePicker.y = kScreenHeight
            }, completion: { (finished:Bool) in
                
                self.datePicker.removeFromSuperview()
                self.backView.removeFromSuperview()
        })
    }
    
    @IBAction func selectedLeaveType(_ sender: UITapGestureRecognizer) {
        
        
    }
    @IBAction func backAction(_ sender: AnyObject) {
 
      _ =  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {

        
        if beginDay.text == "" {
            self.showHint("请点击选择开始时间")
            return
        }
        
        if beginDay.text == "" {
            self.showHint("请点击选择结束时间")
            return
        }
        if leaveDay.text == "" || leaveDay.text == "0"{
            self.showHint("请选择请假时间")
            return
        }
        
        let token = UserDefaults().object(forKey: userToken) as! String!
        NetworkTool.shareNetworkTool.addleaveRequest(token!, started: beginDay.text!, ended: endDay.text!, time: leaveDay.text!,reason:reasonTextView.text!, finishedSel: { (data:ETSuccess) in
            
            if self.type == "再次编辑" {
                
                 _ = self.navigationController?.popToRootViewController(animated: true)
                
            }else{
                _ = self.navigationController?.popViewController(animated: true)
            }
            
        }) { (error:ETError) in
           self.showHint(error.message!)
        }
        
    }
    @IBAction func beginTime(_ sender: UIButton) {
        
        addDatePicker(1)
        UIView.animate(withDuration: 0.4, animations: {
            self.datePicker.y = kScreenHeight*0.7
        })
    }
    @IBAction func endTime(_ sender: UIButton) {
        
        addDatePicker(2)
        UIView.animate(withDuration: 0.4, animations: {
            self.datePicker.y = kScreenHeight*0.7
        })
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



