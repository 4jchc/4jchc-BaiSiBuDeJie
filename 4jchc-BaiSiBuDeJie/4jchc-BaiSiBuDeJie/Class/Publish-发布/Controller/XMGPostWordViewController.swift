//
//  XMGPostWordViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGPostWordViewController: UIViewController {
    
    /** 文本输入控件 */
    var textView:XMGPlaceholderTextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTextView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupTextView(){
        let textView:XMGPlaceholderTextView = XMGPlaceholderTextView()
        
        textView.frame = self.view.bounds;
        textView.placeholder = "把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
        self.view.addSubview(textView)
        
        self.textView = textView;
    }
    //MARK: 设置导航栏
    func setupNav() {
        
        self.title = "发表文字";
        // 设置导航栏标题
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        
        // 设置导航栏左的按钮
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("MainTagSubIcon", target: self, action: "tagClick")
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("MainTagSubIcon", target: self, action: "tagClick")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: UIBarButtonItemStyle.Done, target: self, action: "post")
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
        // 默认不能点击
        self.navigationItem.rightBarButtonItem!.enabled = false
        
        // 强制刷新
        self.navigationController?.navigationBar.layoutIfNeeded()
        
    }
    
    
    func cancel(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func post(){
        
        
    }
    
}
