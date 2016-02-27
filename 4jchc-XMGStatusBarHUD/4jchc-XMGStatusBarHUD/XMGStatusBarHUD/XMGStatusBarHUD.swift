//
//  XMGStatusBarHUD.swift
//  4jchc-XMGStatusBarHUD
//
//  Created by 蒋进 on 16/2/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
let XMGMessageFont:UIFont = UIFont.systemFontOfSize(12)
/** 消息的停留时间 */
let XMGMessageDuration:Double = 2;
/** 消息显示\隐藏的动画时间 */
let XMGAnimationDuration:Double = 0.25;
let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height

class XMGStatusBarHUD: NSObject {
    
    /** 全局的窗口 */
    static var window_:UIWindow!
    /** 定时器 */
    static var timer_:NSTimer?
    
    
    
    
    ///  显示窗口
    static func showWindow(){
        
        // frame数据
        let windowH:CGFloat = 20
        var frame:CGRect = CGRectMake(0, -windowH, ScreenWidth, windowH);
        
        // 显示窗口
        window_ = UIWindow()
        
        window_.backgroundColor = UIColor.blackColor()
        window_.hidden = true
        
        window_.windowLevel = UIWindowLevelAlert;
        window_.frame = frame;
        window_.hidden = false
        
        // 动画
        frame.origin.y = 0;
        UIView.animateWithDuration(XMGAnimationDuration) { () -> Void in
            window_.frame = frame
        }
        
    }
    
    /**
     * 显示普通信息
     * param msg       文字
     * param image     图片
     */
    
    static  func showMessage(msg:String,image:UIImage?){
        // 停止定时器
        timer_?.invalidate()
        
        
        // 显示窗口
        showWindow()
        
        // 添加按钮
        let button:UIButton = UIButton()
        button.setTitle(msg, forState: UIControlState.Normal)
        
        button.titleLabel?.font = XMGMessageFont
        if image != nil{
            
            button.setImage(image, forState: .Normal)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        }
        
        button.frame = window_.bounds;
        window_.addSubview(button)
        
        
        //启动的定时器
        timer_ = NSTimer.scheduledTimerWithTimeInterval( XMGMessageDuration, target: self, selector: "hide", userInfo: nil, repeats: false)
        
        
        
    }
    /**
     * 显示普通信息
     */
    static  func showMessage(msg:String){
        
        showMessage(msg, image: nil)
    }
    
    /**
     * 显示成功信息
     */
    static func showSuccess(msg:String){
        
        NSLog("%", NSTemporaryDirectory());
        showMessage(msg, image: UIImage(named: "XMGStatusBarHUD.bundle/success"))
        
    }
    
    /**
     * 显示失败信息
     */
    static func showError(msg:String){
        
        showMessage(msg, image: UIImage(named: "XMGStatusBarHUD.bundle/error"))
        
    }
    
    /**
     * 显示正在处理的信息
     */
    static func showLoading(msg:String){
        // 停止定时器
        timer_?.invalidate()
        timer_ = nil;
        
        // 显示窗口
        showWindow()
        
        // 添加文字
        let label:UILabel = UILabel()
        label.font = XMGMessageFont;
        label.frame = window_.bounds;
        label.textAlignment = NSTextAlignment.Center;
        label.text = msg;
        label.textColor = UIColor.whiteColor()
        window_.addSubview(label)
        
        // 添加圈圈
        let loadingView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        loadingView.startAnimating()
        // 文字宽度
        let msgW:CGFloat = (msg as NSString).sizeWithAttributes([NSFontAttributeName:XMGMessageFont]).width
        let centerX:CGFloat = (window_.frame.size.width - msgW) * 0.5 - 20;
        
        let centerY:CGFloat = window_.frame.size.height * 0.5;
        loadingView.center = CGPointMake(centerX, centerY);
        
        window_.addSubview(loadingView)
        
        
    }
    
    /**
     * 隐藏
     */
    static func hide(){
        
        
        weak var weakwindow_ = window_

        UIView.animateWithDuration(XMGAnimationDuration, animations: { () -> Void in
            
            if weakwindow_ != nil{
        
                var frame:CGRect = (weakwindow_!.frame)
                weakwindow_!.frame = frame
                frame.origin.y =  -frame.size.height;
                weakwindow_!.frame = frame;
            }
        

            }) { (finished) -> Void in
                
                window_ = nil;
                timer_ = nil;
                
        }
        
    }
}
