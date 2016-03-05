//
//  XMGAddTagViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/5.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGAddTagViewController: UIViewController {
    
    /** 内容 */
    var contentView:UIView?

    /** 文本输入框 */
    var textField:UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupContentView()
        setupTextFiled()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 主动召唤键盘
        textField!.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 主动隐藏键盘
        textField!.resignFirstResponder()
    }

    //MARK: 设置视图容器
    func setupContentView(){
        
        let contentView:UIView = UIView()
        contentView.x = XMGTopicCellMargin;
        contentView.width = self.view.width - 2 * contentView.x;
        contentView.y = 64 + XMGTopicCellMargin;

        contentView.height = XMGScreenH;
        
        self.view.addSubview(contentView)
        self.contentView = contentView;
    }

    //MARK: 设置多行文本
    func setupTextFiled(){
        
        let textField:UITextField = UITextField()
        textField.width = XMGScreenW;
        textField.height = 25;
        textField.placeholder = "多个标签用逗号或者换行隔开"
        textField.addTarget(self, action: "textDidChange", forControlEvents: UIControlEvents.EditingChanged)
        textField.becomeFirstResponder()
        self.contentView!.addSubview(textField)
        self.textField = textField;
    }

    ///  监听文字改变
    func textDidChange(){
        
        if (self.textField!.hasText()) { // 有文字
            // 显示"添加标签"的按钮
            self.addButton.hidden = false
            self.addButton.y = CGRectGetMaxY(self.textField!.frame) + XMGTopicCellMargin;
            self.addButton.setTitle("添加标签:\(self.textField!.text!)", forState: .Normal)
           
        } else { // 没有文字
            // 隐藏"添加标签"的按钮
            self.addButton.hidden = true
        }
    }

    
    //MARK: 设置导航栏
    func setupNav() {
        
        self.title = "添加标签";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Done, target: self, action: "done")
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
        // 默认不能点击
        self.navigationItem.rightBarButtonItem!.enabled = false


    }
    
    
    func cancel(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func done(){
        
        
    }

    
    private lazy  var addButton: UIButton = {
        let btn = UIButton()
        btn.width = self.contentView!.width;
        btn.height = 35;
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, XMGTopicCellMargin, 0, XMGTopicCellMargin);
        // 让按钮内部的文字和图片都左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        btn.backgroundColor = UIColor.RGB(74, 139, 209);
        btn.addTarget(self, action: "addBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView!.addSubview(btn)
        return btn
    }()
    

    /// 监听"添加标签"按钮点击
    func addBtnClick(){
        
        
    }

    
    
    
    

}
