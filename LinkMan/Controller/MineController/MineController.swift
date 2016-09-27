
//
//  MineController.swift
//  swfit_uikit_demo
//
//  Created by Enjoytouch on 16/7/18.
//  Copyright © 2016年 shuzhenguo. All rights reserved.
//

import UIKit

class MineController: UIViewController {

    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var online: UILabel!
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
        online.text = NetworkTool.shareNetworkTool.judgeNetWork()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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









