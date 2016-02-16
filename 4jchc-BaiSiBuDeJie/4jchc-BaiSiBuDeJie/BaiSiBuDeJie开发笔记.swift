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
    //MARK: 2. 自定义TabBar修改位置
    1.KVC换掉系统的TabBar
    setValue(newTabBar, forKey: "tabBar")
    2.init(frame: CGRect)里设置子控件的frame是没有用的要在layoutSubviews里设置
    3.UITabBarButton为私有 let Class:AnyClass = NSClassFromString("UITabBarButton")!
    */

    /*
    //MARK: 3. 设置导航栏
    1.添加Frame的扩展
    2.封装UIBarButtonItem
    3.添加自定义打印log
    */

    /*
    //MARK: 4. 调整项目文件结构
    */


    /*
    //MARK: 5. 自定义导航控制器拦截push设置返回键super的push要放在后面
    */

    /*
    //MARK: 6. 当第一次使用这个类的时候会调用一次initialize的使用

    */

    /*
    //MARK: 7. 添加第三方库
    */

    /*
    发送网络请求
    */






//MARK: - 第二天

    /*
    添加MJExtension设置左边的数据--获取右边list列表
    1.获取左边list列表
    2.当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
    在自定义cell的setSelected里设置选中的高亮状态
    3.mj字典转模型
    XMGRecommendCategory.mj_objectArrayWithKeyValuesArray(responseObject["list"])
    4.自定义Insets嵌入为64--导航栏
    设置automatically自动地 Adjusts调整 ScrollView Insets嵌入
    self.automaticallyAdjustsScrollViewInsets = false
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    */

