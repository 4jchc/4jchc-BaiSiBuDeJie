//
//  XMGLoginRegisterViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/18.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGLoginRegisterViewController: UIViewController {

    /** 登录框距离控制器view左边的间距 */
    @IBOutlet weak var loginViewLeftMargin: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


    
    /// 点击别的地方会结束编辑
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    @IBAction func back(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func showLoginOrRegister(sender: UIButton) {
        // 退出键盘
        self.view.endEditing(true)
        if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
            self.loginViewLeftMargin.constant = -self.view.width;
            sender.selected = true
            //        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
        } else { // 显示登录界面
            self.loginViewLeftMargin.constant = 0;
            sender.selected = false
            //        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }

    
    //MARK: 让当前控制器对应的状态栏是白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent;
    }
}







