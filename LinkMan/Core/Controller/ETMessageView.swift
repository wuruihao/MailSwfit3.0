//
//  ETMessageView.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/30.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

enum Message {
    
    case alert
    case animation
    case alertDelay
    case animationDelay
}

let viewWidth: CGFloat = 100.0
let viewHeight: CGFloat  = 60.0
let viewWidthMax: CGFloat  = 160.0

extension String {
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(.zero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            textSize = self.size(attributes: attributes as? [String : Any])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as? [String : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}


class ETMessageView: UIView {
    
    // 单例
    static let share = ETMessageView()
    
    var timer: Timer!
    
    func show(message:String, onView:UIView, type:Message){
        
        switch type {
        case .alert:
            self.show(message: message, onView: onView, isHiddenSpinner: true)
            break
        case .animation:
            self.show(message: message, onView: onView, isHiddenSpinner: false)
            break
        case .alertDelay:
            
            self.show(message: message, onView: onView, isHiddenSpinner: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.hide()
            }
            break
        case .animationDelay:
            self.show(message: message, onView: onView, isHiddenSpinner: false)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.hide()
            }
            break
        }
        
    }
    
    func show(message:String, onView:UIView, isHiddenSpinner:Bool){
        
        self.frame = CGRect(x: (kScreenWidth-viewWidth)*0.5, y: kScreenHeight*0.4, width: viewWidth, height: viewHeight)
        if self.backView.superview == nil{
            self.addSubview(self.backView)
        }
        if self.messageLabel.superview == nil {
            self.addSubview(self.messageLabel)
        }
        if isHiddenSpinner == false {
            if self.spinner.superview == nil {
                self.addSubview(self.spinner)
            }
            self.spinner.startAnimating()
        }
        
        let showSize = CGSize(width: viewWidthMax-20, height: CGFloat(MAXFLOAT))
        
        let textSize = message.textSizeWithFont(font: self.messageLabel.font, constrainedToSize: showSize)
        
        if textSize.width > viewWidth {
            self.size = CGSize(width: textSize.width+20, height: viewHeight)
        }
        
        self.centerX = kScreenWidth*0.5
        
        let lines:Int = Int(textSize.height)
        let line:Int = Int(self.messageLabel.font.lineHeight)
        self.messageLabel.numberOfLines = lines/line
        self.messageLabel.size = textSize
        self.messageLabel.text = message
        
        if self.messageLabel.width < showSize.width {
            
            self.messageLabel.centerX = self.width*0.5
            self.backView.size = self.frame.size
        }
        
        if self.messageLabel.height > viewHeight-20 {
            
            if isHiddenSpinner == false {
                self.messageLabel.y = self.spinner.y+self.spinner.height
                self.height = self.messageLabel.height+self.messageLabel.y+10
                self.spinner.size = CGSize(width: self.width, height: self.height-self.messageLabel.height-10)
                self.messageLabel.centerX = self.width*0.5
                self.backView.size = self.frame.size
            }else{
                self.height = self.messageLabel.height+10
                self.backView.size = self.frame.size
            }
        }else{
            if isHiddenSpinner == true {
                self.messageLabel.centerY = self.height*0.5
            }else{
                self.messageLabel.y = self.spinner.y+self.spinner.height
                self.height = self.messageLabel.height+self.messageLabel.y+10
                self.width = self.height
                self.messageLabel.centerX = self.width*0.5
                self.spinner.size = CGSize(width: self.width, height: self.height-self.messageLabel.height-10)
                self.backView.size = self.frame.size
            }
        }
        if self.superview == nil {
            onView.addSubview(self)
        }
    }
    func hide(){
        self.removeFromSuperview()
        spinner.removeFromSuperview()
    }
    
    /// 名称
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.black
        return nameLabel
    }()
    
    /// 背景
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        view.backgroundColor = RGBA(r: 38.0, g: 38.0, b: 38.0, a: 1.0)
        view.layer.cornerRadius = 10
        return view
    }()
    
    /// 加载
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.origin = CGPoint(x: 0, y: 0)
        view.size = CGSize(width: 80, height: 80)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// 消息
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    
    
    
    
}
