//
//  UIImage+Extendion.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/8/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//
//  设置圆角
//

import UIKit

extension UIImage {
    
    func circleImage() -> UIImage {
        // false 代表透明
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 获得上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 添加一个圆
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctx?.addEllipse(in: rect)
        
        // 裁剪
        ctx?.clip()
        // 将图片画上去
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
}

