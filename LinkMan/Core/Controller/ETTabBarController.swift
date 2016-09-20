//
//  ETTabBarController.swift
//  swfit_uikit_demo
//
//  Created by Enjoytouch on 16/7/18.
//  Copyright © 2016年 shuzhenguo. All rights reserved.
//

import UIKit

class ETTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupSubView(){
        
        let homeController = HomeController()
        
        addChildViewController(homeController,
                               title: "首页",
                               image: UIImage(named: "TabBar_home.png")!,
                               selectedImage: UIImage(named: "TabBar_home_sel.png")!)
        
        /*
        let contactsController = ContactsController()
        
        addChildViewController(contactsController,
                               title: "联系人",
                               image: UIImage(named: "TabBar_interesting.png")!,
                               selectedImage: UIImage(named: "TabBar_interesting_sel.png")!)
        */
        let departmentController = DepartmentController()
        
        addChildViewController(departmentController,
                               title: "部门",
                               image: UIImage(named: "TabBar_product.png")!,
                               selectedImage: UIImage(named: "TabBar_product_sel.png")!)
        
        let mineController = MineController()
        
        addChildViewController(mineController,
                               title: "我的",
                               image: UIImage(named: "TabBar_mine.png")!,
                               selectedImage: UIImage(named: "TabBar_mine_sel.png")!)
        
    }

    fileprivate func addChildViewController(_ controller:UIViewController,title:String,image:UIImage,selectedImage:UIImage){
        
        controller.title = title;
        controller.tabBarItem.image = image;
        controller.tabBarItem.selectedImage = selectedImage;
        
        let navi = ETNavigationController(rootViewController: controller)
        navi.navigationBar.isHidden = true
        addChildViewController(navi)
        
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
