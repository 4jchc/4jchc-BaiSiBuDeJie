//
//  XMGPushGuideView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/19.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGPushGuideView: UIView {

   class func show(){

        if isNewupdate() == true{
            
            let window:UIWindow = UIApplication.sharedApplication().keyWindow!
            let guideview = XMGPushGuideView.viewFromXIB()
            guideview.frame = window.bounds
            window.addSubview(guideview)
            
        }
    }
    
    class func isNewupdate() -> Bool{
        // 1.获取当前软件的版本号 --> info.plist
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 2.获取以前的软件版本号 --> 从本地文件中读取(以前自己存储的)
        let sandboxVersion =  NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        
        print("current = \(currentVersion) sandbox = \(sandboxVersion)")
        
        // 3.比较当前版本号和以前版本号
        //   2.0                    1.0
        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending{
            // 3.1如果当前>以前 --> 有新版本
            // 3.1.1存储当前最新的版本号
            // iOS7以后就不用调用同步方法了
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            return true
        }
        
        // 3.2如果当前< | ==  --> 没有新版本
        return false
    }
    
    /*
    class func guideView()->XMGPushGuideView{
    
    return NSBundle.mainBundle().loadNibNamed("XMGPushGuideView", owner: nil, options: nil).last as! XMGPushGuideView
    
    }
    */

    
    @IBAction func close(sender: UIButton) {
        
        self.removeFromSuperview()
    }

}
