
//
//  MineController.swift
//  swfit_uikit_demo
//
//  Created by Enjoytouch on 16/7/18.
//  Copyright © 2016年 shuzhenguo. All rights reserved.
//

import UIKit
import AFNetworking

class MineController: UIViewController {
    
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var online: UILabel!
    
    // var reachability: AFNetworkReachabilityManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let headImage = UserDefaults().object(forKey: userHeadImg) as! String!
        if headImage != nil {
            snapImage.sd_setImage(with: URL.init(string: headImage!), placeholderImage: UIImage(named: "sanp.png"))
        }
        let realName = UserDefaults().object(forKey: userRealName) as! String!
        if realName != nil {
            name.text = realName
        }
        
        networkStatusListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
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
                online.text = "WiFi网络"
            } else if AFNetworkReachabilityManager.shared().isReachableViaWWAN {
                online.text = "移动网络"
            }
        }else{
            print("网络连接：不可用")
            print("连接类型：没有网络连接")
            online.text = "网络不给力"
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
    
    /*个人资料*/
    @IBAction func chickSeeMyInfo(_ sender: AnyObject) {
        
        let memberVC = MemberInfoController()
        memberVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(memberVC, animated: true)
        
    }
    /*修改密码*/
    @IBAction func modifyPassword(_ sender: AnyObject) {
        
        self.showHint("修改密码")
    }
    /*设置*/
    @IBAction func setupConfigure(_ sender: AnyObject) {
        
        self.showHint("设置")
    }
    /*注销*/
    @IBAction func logout(_ sender: AnyObject) {
        
        self.showHint("注销")
    }
}









