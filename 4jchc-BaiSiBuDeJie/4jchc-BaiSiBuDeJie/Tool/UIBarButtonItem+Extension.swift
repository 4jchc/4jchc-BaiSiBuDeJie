//
//  UIBarButtonItem.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //MARK:  自定义UIButton按钮设置正常&高亮&点击事件
    ///  自定义UIButton按钮设置正常&高亮&点击事件
    class func ItemWithBarButtonItem(image:String, target: AnyObject?, action:String?) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: image + "-click"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        btn.size = btn.currentBackgroundImage!.size;
        return UIBarButtonItem(customView: btn)
    }
}
