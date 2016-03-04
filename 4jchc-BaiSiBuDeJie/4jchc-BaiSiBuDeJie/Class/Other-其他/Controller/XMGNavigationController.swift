//
//  XMGNavigationController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGNavigationController: UINavigationController {



    // 当第一次使用这个类的时候会调用一次
    override class func initialize(){
        /*
        let navibar = UINavigationBar.appearance()
        navibar.tintColor = UIColor.whiteColor()
        let navBarBg = "NavBar64"
        navibar.setBackgroundImage(UIImage(named: navBarBg), forBarMetrics: UIBarMetrics.Default)
        */
        // 正常状态
        var normalAttrs = [String:AnyObject]()
        normalAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        normalAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)

        // Disabled残废的状态
        var disabledAttrs = [String:AnyObject]()
        disabledAttrs[NSForegroundColorAttributeName] = UIColor.lightGrayColor()

        let navBar:UINavigationBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
        navBar.setTitleVerticalPositionAdjustment(11, forBarMetrics: UIBarMetrics.Default)
        // 当导航栏用在XMGNavigationController中, appearance设置才会生效
        //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
        // 设置tabbarItem的字体选中的颜色
        let item = UIBarButtonItem.appearance()
        // UIControlStateNormal
        item.setTitleTextAttributes(normalAttrs, forState: .Normal)
        // UIControlStateDisabled
        item.setTitleTextAttributes(disabledAttrs, forState: .Disabled)
      
  
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        //使用kvc，替换掉系统的navigationBar（系统的navigationBar是readOnly的）
        self.setValue(ZYNavigationBar(), forKeyPath: "navigationBar")
        */
    }
    
    
    
    
    // 可以在这个方法中拦截所有push进来的控制器更改返回按钮
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        
        // 如果当前导航控制器里面有1个子控制器,那么执行到这个地方的时候,就代表
        // 将要push进来第2个,把 push 进来 的控制器的左边按钮改成第一个控制器的title
        
        // 判断内部如果已经存在过控制器,才执行逻辑
        if childViewControllers.count != 0 {
            var title: String = "返回"
            
            // 如果当前导航控制器里面有1个子控制器,那么做特殊处理
            if childViewControllers.count == 1 {
                // push 第2个
                title = childViewControllers.first!.title ?? title
            }
            
            // 判断如果当前push进来的是rootviewcontroller,就不设置navigationButtonReturn
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithBarButtonItemBackTitle("返回", image: "navigationButtonReturn", target: self, action: "back")

            // 隐藏底部 tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        

    }

    
    @objc private func back(){
        popViewControllerAnimated(true)
    }

}
