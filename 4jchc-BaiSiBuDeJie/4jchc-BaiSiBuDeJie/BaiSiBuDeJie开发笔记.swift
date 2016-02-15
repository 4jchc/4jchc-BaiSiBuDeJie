//
//  BaiSiBuDeJie开发笔记.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


//MARK: - 第一天
    /*
    //MARK: 1. 自定义UITabBarController子控制器
    UITabBarItem的外观appearance
     通过appearance统一设置所有UITabBarItem的文字属性
     后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置

    */

    /*
    自定义TabBar修改位置
    1.KVC换掉系统的TabBar
    setValue(newTabBar, forKey: "tabBar")
    2.init(frame: CGRect)里设置子控件的frame是没有用的要在layoutSubviews里设置
    3.UITabBarButton为私有 let Class:AnyClass = NSClassFromString("UITabBarButton")!
    */