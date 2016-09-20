
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
        print("修改密码")
    }
    /*设置*/
    @IBAction func setupConfigure(_ sender: AnyObject) {
        print("设置")
    }
    /*注销*/
    @IBAction func logout(_ sender: AnyObject) {
        print("注销")
    }
}









