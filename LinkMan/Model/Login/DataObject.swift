//
//  DataObject.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/28.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class DataObject: NSObject {

}

class MemberData: NSObject {
    
    var id:         Int = 0
    var sex:        Int = 0
    var name:       String?
    var mobile:     String?
    var token:      String?
    var email:      String?
    var level:      String?
    var head_img:   String?
    var nickname:   String?
    var department: String?
    var department_id: Int = 0
    var level_id: String?
    
}

class LeaveData: NSObject {
    
    var id:      Int = 0
    var started: String?
    var ended:   String?
    var time:    Int = 0
    var name:    String?
    var status:  String?
    var created: String?
    var head_img:String?
    var department:String?
    
    
    var reason:  String?
    var mobile:  String?
    
}

class DepartmentData: NSObject {
    
    var id:      Int = 0
    var name:    String?
    var number:  String?
    var members: NSMutableArray?
}

class NotifyData: NSObject {
    
    var snap : String?
    var name : String?
    var time : String?
    var status : String?
    var title  : String?
    var subTitle : String?
    
    
    init(n:String,s:String,t:String,st:String,ti:String,subTi:String) {
        
        super.init()
        
        name = n
        snap = s
        time = t
        status = st
        title = ti
        subTitle = subTi
        
    }
}
class HomeData: NSObject {
    
    var title : String?
    var icon : String?
    
    
    init(name:String,sanp:String) {
        
        super.init()
        
        title = name
        icon = sanp
        
    }
}

