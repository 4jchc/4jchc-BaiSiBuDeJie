//
//  XMGTabBarController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTabBarController: UITabBarController {

    
    
    override class func initialize(){
        
        var attr = [String:AnyObject]()
        attr[NSForegroundColorAttributeName] = UIColor.grayColor()
        attr[NSFontAttributeName] = UIFont.systemFontOfSize(12)
        
        var selectedAttrs = [String:AnyObject]()
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.darkGrayColor()
        selectedAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(12)
        
        // 设置tabbarItem的字体选中的颜色
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttrs, forState:.Selected)
        UITabBarItem.appearance().setTitleTextAttributes(attr, forState:.Normal)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //设置tabbar
    func setTabBar() {
        
         let newTabBar = XMGTabBar(frame: tabBar.bounds)
        setValue(newTabBar, forKey: "tabBar")
    }
    //添加所有子控制器
    func addChildViewControllers() {
        
        addChildVc("精华", image: "tabBar_essence_icon", selectedImage: "tabBar_essence_click_icon",childVc: XMGEssenceViewController())
        
        addChildVc("最新", image: "tabBar_new_icon", selectedImage: "tabBar_new_click_icon",childVc: XMGNewViewController())
        
        addChildVc("关注", image: "tabBar_friendTrends_icon", selectedImage: "tabBar_friendTrends_click_icon",childVc: XMGFriendTrendsViewController())
        
        addChildVc("我", image: "tabBar_me_icon", selectedImage: "tabBar_me_click_icon",childVc: XMGMeViewController())
        
    }

    //MARK:  添加子控制器+UITabBar封装-UIViewController版
    /// 添加子控制器+UITabBar封装-UIViewController版
    func addChildVc(title:String ,image:String, selectedImage:String,childVc:UIViewController){

        // 设置子控制器的文字
        childVc.title = title  // 同时设置tabbar和navigationBar的文字

        childVc.tabBarItem.image = UIImage(named: image)
        // 声明：这张图片按照原始的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

        
        // 先给外面传进来的小控制器 包装 一个导航控制器
        let nav:UINavigationController = UINavigationController(rootViewController: childVc)
        
        /// 添加为子控制器
        self.addChildViewController(nav)
        
    }

    
}
