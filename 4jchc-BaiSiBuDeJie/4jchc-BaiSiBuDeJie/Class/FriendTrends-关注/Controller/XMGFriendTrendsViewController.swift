//
//  XMGFriendTrendsViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGFriendTrendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏标题
        self.navigationItem.title = "我的关注";

        // 设置导航栏右边的按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("friendsRecommentIcon", target: self, action: "friendsClick")
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
    }
    
    func friendsClick()
    {
        printLog("")
        let composeVC = XMGRecommendViewController()
        self.navigationController?.pushViewController(composeVC, animated: true)
    }
    

    @IBAction func loginRegister(sender: AnyObject) {
        

        let login = XMGLoginRegisterViewController()
        self.presentViewController(login, animated: true, completion: nil)
  
    }


}
