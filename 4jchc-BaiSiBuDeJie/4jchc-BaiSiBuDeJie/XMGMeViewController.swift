//
//  XMGMeViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏标题
        self.navigationItem.title = "我的";
        let settingItem:UIBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("mine-setting-icon", target: self, action: "settingClick")
        let moonItem:UIBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("mine-moon-icon", target: self, action: "moonClick")
        
        // 设置导航栏右边的按钮
        self.navigationItem.rightBarButtonItems = [settingItem, moonItem];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func settingClick()
    {
    printLog("")
    }
    
    func moonClick()
    {
    printLog("")
    }

}
