//
//  XMGEssenceViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGEssenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏标题
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        
        // 设置导航栏左的按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("MainTagSubIcon", target: self, action: "tagClick")
        
    }
    
    func tagClick()
    {
        printLog("")
    }
    
}
