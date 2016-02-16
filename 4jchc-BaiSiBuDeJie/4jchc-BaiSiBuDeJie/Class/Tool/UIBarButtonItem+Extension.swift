//
//  UIBarButtonItem.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //MARK:  【Nav-按钮-无文字】-UIButton设置正常&高亮&点击事件
    ///  【Nav-按钮-无文字】-UIButton设置正常&高亮&点击事件
    class func ItemWithBarButtonItem(image:String, target: AnyObject?, action:String?) ->UIBarButtonItem {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: image + "-click"), forState: UIControlState.Highlighted)
        button.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        button.size = button.currentBackgroundImage!.size;
        return UIBarButtonItem(customView: button)
    }
    //MARK:  【Nav-按钮-有文字-返回】-UIButton设置正常&高亮&点击事件
    ///  【Nav-按钮-有文字-返回】-UIButton设置正常&高亮&点击事件
    class func ItemWithBarButtonItemBackTitle(title:String?,image:String, target: AnyObject?, action:String?) ->UIBarButtonItem {
        let button = UIButton()
        //添加字体
        if title!.characters.count > 0 {
            
            button.setTitle(title, forState: UIControlState.Normal)
            //设置字体大小
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            
            //设置字体颜色
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        }
        button.setImage(UIImage(named: image), forState: UIControlState.Normal)
        button.setImage(UIImage(named: image + "-click"), forState: UIControlState.Highlighted)
        button.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        //button.size = button.currentImage!.size;
        // 有图片和文字
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        return UIBarButtonItem(customView: button)
    }

}
