//
//  UITabBarController+UITabBar.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//



import Foundation
import UIKit
extension UITabBarController{
    
    
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
        nav.navigationBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
        /// 添加为子控制器
        self.addChildViewController(nav)
        
    }
    

    
    
}