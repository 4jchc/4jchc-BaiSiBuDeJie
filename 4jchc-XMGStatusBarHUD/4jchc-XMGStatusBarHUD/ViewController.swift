//
//  ViewController.swift
//  4jchc-XMGStatusBarHUD
//
//  Created by 蒋进 on 16/2/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func message(sender: AnyObject){
        
        XMGStatusBarHUD.showMessage("没有什么事!!!!", image: UIImage(named: "check"))

    }
    
    @IBAction func hide(sender: AnyObject) {
        
        XMGStatusBarHUD.hide()
        
    }
    
    @IBAction func loading(sender: AnyObject){
        XMGStatusBarHUD.showLoading("正在加载中...")
        
    }
    @IBAction func error(sender: AnyObject){
        
        XMGStatusBarHUD.showError("加载失败!")
    }
    @IBAction func success(sender: AnyObject){
        
        XMGStatusBarHUD.showSuccess("加载成功!")
        
        
    }

}

