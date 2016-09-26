//
//  LinkMan.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/19.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

let userID = "userID"
let userSex = "userSex"
let userRealName = "userRealName"
let userMobile = "userMobile"
let userToken = "userToken"
let userLevel = "userLevel"
let userHeadImg = "userHeadImg"
let userNickname = "userNickname"
let userDepartment = "userDepartment"

let messageLogin = "加载中..."
let messageLoading = "正在登录中…"
let messageUnknown = "未知网络"
let messageNotReachable = "网络不给力"
let messageViaWWAN = "移动网络"
let messageViaWiFi = "WiFi网络"


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

func kFitWidth(value : CGFloat) -> CGFloat {
    return (kScreenWidth/750.0*value)
}
func kFitHeight(value : CGFloat) -> CGFloat {
    return kScreenWidth/1334.0*value
}
func kFontSize(value : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: kScreenHeight/750*value)
}
func FontSize(value : CGFloat) -> CGFloat {
    return (kScreenHeight/750*value)
}
func kBoldFitSize(value : CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: kScreenHeight/750*value)
}
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


