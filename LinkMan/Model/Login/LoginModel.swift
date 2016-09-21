//
//  LoginModel.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class MemberData: NSObject {
    
    var id:         Int = 0
    var sex:        String?
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
