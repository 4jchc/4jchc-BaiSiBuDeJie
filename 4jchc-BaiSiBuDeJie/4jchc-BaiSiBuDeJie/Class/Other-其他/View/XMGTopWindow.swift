//
//  XMGTopWindow.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/2.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopWindow: NSObject {
    
    /** 全局的窗口 */
    static var window_:UIWindow?
    ///  显示窗口
    static func show(){

        window_!.hidden = false
        
    }
    
    static func hide(){
        window_!.hidden = true
    }
    // 当第一次使用这个类的时候会调用一次
    override class func initialize(){
        
        // frame数据
        let frame:CGRect = CGRectMake(0, 0, XMGScreenW, 20);
        
        // 显示窗口
        window_ = UIWindow()
        window_?.backgroundColor = UIColor.redColor()
        window_!.windowLevel = UIWindowLevelAlert;
        window_!.frame = frame;
        window_?.rootViewController = UiwindViewController()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "windowClick")
        self.window_!.addGestureRecognizer(tap)
        window_!.makeKeyAndVisible()
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
        printLog("superview11-\(window.superview?.subviews)")
    }
    
    /// 监听窗口点击
    static func windowClick() {
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!

        searchScrollViewInView(window)
    }
    
    static func searchScrollViewInView(superview:UIView){
        

        for subview in superview.subviews{
            
            //CGRectIntersectsRect(UIApplication.sharedApplication().keyWindow!.bounds, subview.frame)
            
            //let subview = subview as? UIScrollView
            // 如果是scrollview, 滚动最顶部
            if subview.isKindOfClass(UIScrollView.self){
                let subview = subview as! UIScrollView
                var offset:CGPoint = subview.contentOffset
                offset.y = -subview.contentInset.top;
                subview.setContentOffset(offset, animated: true)
                
            }
            // 继续查找子控件
            self.searchScrollViewInView(subview)
        }
        
    }
    
    
    
}