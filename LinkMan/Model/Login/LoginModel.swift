//
//  LoginModel.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class MemberData: NSObject {
    
    var id:         Int?
    var sex:        String?
    var name:       String?
    var mobile:     String?
    var token:      String?
    var level:      String?
    var head_img:   String?
    var nickname:   String?
    var department: String?
    
}


class LeaveData: NSObject {
    
    var started: String?
    var ended:   String?
    var time:    String?
    var name:    String?
    var status:  String?
    var created:  String?
    
    var reason:  String?
    var mobile:  String?
    
}
