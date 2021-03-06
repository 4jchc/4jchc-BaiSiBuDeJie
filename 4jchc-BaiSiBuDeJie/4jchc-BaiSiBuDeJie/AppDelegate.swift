//
//  AppDelegate.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

@UIApplicationMain //UITabBarControllerDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // 1.创建window窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        // 2.设置窗口的根控制器
        
        // 设置tabBarController代理
        let tabBarControlle:XMGTabBarController = XMGTabBarController()
        //tabBarControlle.delegate = self;
        window?.rootViewController = tabBarControlle//XMGTabBarController()
        // 3.显示窗口
        
        window?.makeKeyAndVisible()

        // 显示推送引导
        XMGPushGuideView.show()
        // 添加一个window, 点击这个window, 可以让屏幕上的scrollView滚到最顶部
        //XMGTopWindow.show( )
        
        return true
    }
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        printLog("发出通知")
        // 发出一个通知
        XMGNoteCenter.postNotificationName(XMGTabBarDidSelectNotification, object: self, userInfo: nil)

    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
                
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

