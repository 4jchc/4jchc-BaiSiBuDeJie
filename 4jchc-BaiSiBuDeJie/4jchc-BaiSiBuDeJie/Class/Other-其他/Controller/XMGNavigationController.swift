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
        
        let bar:UINavigationBar = UINavigationBar.appearance()
        bar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
