//
//  YMConst.swift
//  DanTang
//
//  Created by 杨蒙 on 16/7/20.
//  Copyright © 2016年 hrscy. All rights reserved.
//
import UIKit

enum YMTopicType: Int {
    /// 精选
    case selection = 4
    /// 美食
    case food = 14
    /// 家居
    case household = 16
    /// 数码
    case digital = 17
    /// 美物
    case goodThing = 13
    /// 杂货
    case grocery = 22
}

enum YMShareButtonType: Int {
    /// 微信朋友圈
    case weChatTimeline = 0
    /// 微信好友
    case weChatSession = 1
    /// 微博
    case weibo = 2
    /// QQ 空间
    case qZone = 3
    /// QQ 好友
    case qqFriends = 4
    /// 复制链接
    case copyLink = 5
}

enum YMOtherLoginButtonType: Int {
    /// 微博
    case weiboLogin = 100
    /// 微信
    case weChatLogin = 101
    /// QQ
    case qqLogin = 102
}

/// iid 未登录用户 id，只要安装了今日头条就会生成一个 iid
/// 可以在自己的手机上安装一个今日头条，然后通过 charles 抓取一下这个 iid，
/// 替换成自己的，再进行测试
let IID = 5034850950
let device_id = 6096495334
let version_code = "5.7.1"
/// tabBar 被点击的通知
let YMTabBarDidSelectedNotification = "YMTabBarDidSelectedNotification"

/// 服务器地址
let BASE_URL = "http://address.uduoo.com"
/// 第一次启动
let YMFirstLaunch = "firstLaunch"
/// 是否登录
let isLogin = "isLogin"

/// code 码 200 操作成功
let RETURN_OK = 200
/// 间距
let kMargin: CGFloat = 10.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
/// 我的界面头部图像的高度
let kYMMineHeaderImageHeight: CGFloat = 210
//  个人界面 cell 高度
let kMineCellH: CGFloat = 50


/// RGBA的颜色设置
func YMColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func YMGlobalColor() -> UIColor {
    return YMColor(245, g: 245, b: 245, a: 1)
}

/// 红色
func YMGlobalRedColor() -> UIColor {
    return YMColor(245, g: 80, b: 83, a: 1.0)
}

/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false
