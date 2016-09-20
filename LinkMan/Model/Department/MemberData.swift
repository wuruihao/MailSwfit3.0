//
//  MemberData.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/6.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit


class Organization: NSObject {
    
    var id: String?
    var name: String?
    var departments: NSMutableArray?
    
    override init() {
        
        id = "1"
        name = "触悦"
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = "1"
        name = "触悦"
    }
    
    func demo(){
        
        let array = NSMutableArray()
        
        let depa = Department()
        depa.demo()
        let depa2 = Department()
        depa2.demo()
        let depa3 = Department()
        depa3.demo()
        let depa4 = Department()
        depa4.demo()
        
        array.addObjects(from: [depa,depa2,depa3,depa4])
        departments = array
    }
}

class Department: NSObject {
    
    var id: String?
    var number: String?
    var name: String?
    var icon: String?
    var members: NSMutableArray?
    
    override init() {
        
        id = "1"
        name = "iOS部门"
        number = "3"
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = "1"
        name = "iOS部门"
        number = "3"
    }
    
    func demo(){
        
        let array = NSMutableArray()
        let depa = MemberData1(name: "吴瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let depa2 = MemberData1(name: "瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let depa3 = MemberData1(name: "吴豪", sanp: "Login_male.png", level: "iOS工程师")
        let depa4 = MemberData1(name: "吴瑞", sanp: "Login_male.png", level: "iOS工程师")
        array.addObjects(from: [depa,depa2,depa3,depa4])
        members = array
    }

}


class MemberData1: NSObject {
    
    var memberId : String?
    var memberName : String?
    var memberSex : String?
    var memberSanp : String?
    var memberLevel : String?
    
    
    init(name:String, sanp:String, level:String){
        
        super.init()
        
        memberId = "1"
        memberName = name
        memberSex = "1"
        memberSanp = sanp
        memberLevel = level
    }
    
    init(dict:[String :AnyObject]) {
        
        super.init()
        
        memberId = "1"
        memberName = "吴瑞豪"
        memberSex = "1"
        memberSanp = "Login_male.png"
        
        /*
         memberId = dict["memberId"] as? String
         memberName = dict["name"] as? String
         memberSex = dict["sex"] as? String
         memberSanp = dict["sanp"] as? String
         */
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

class ApplicationData: NSObject {
    
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
