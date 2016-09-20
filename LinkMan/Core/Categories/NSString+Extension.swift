//
//  NSString+Extension.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/8/8.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit

extension NSString {
    /// 返回文字的高度
    class func boundingRectWithString(_ string: NSString, size: CGSize, fontSize: CGFloat) -> CGFloat {
        return string.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    
    // 处理日期的格式
    class func changeDateTime(_ publish_time: Int) -> String {
        // 把秒转化成时间
        let publishTime = Date(timeIntervalSince1970: TimeInterval(publish_time))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let delta = Date().timeIntervalSince(publishTime)
        
        if (delta <= 0) {
            return "刚刚"
        }
        else if (delta < 60) {
            return "\(Int(delta))秒前"
        }
        else if (delta < 3600) {
            return "\(Int(delta / 60))分钟前"
        }
        else {
            let calendar = Calendar.current
            // 现在
            let comp = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second], from: Date())
            // 发布时间
            let comp2 = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second], from: publishTime)
            
            if comp.year == comp2.year {
                if comp.day == comp2.day {
                    return "\(comp.hour! - comp2.hour!)小时前"
                } else {
                    return "\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
                }
            } else {
                return "\(comp2.year)-\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
            }
        }
    }
    
}
