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
    /** 所有的标签按钮 */
    lazy var tagButtons = NSMutableArray()
    
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
        contentView.x = XMGTagMargin;
        contentView.width = self.view.width - 2 * contentView.x;
        contentView.y = 64 + XMGTagMargin;

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
            self.addButton.y = CGRectGetMaxY(self.textField!.frame) + XMGTagMargin;
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
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, XMGTagMargin, 0, XMGTagMargin);
        // 让按钮内部的文字和图片都左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        btn.backgroundColor = UIColor.RGB(74, 139, 209);
        btn.addTarget(self, action: "addBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView!.addSubview(btn)
        return btn
    }()
    

    /// 监听"添加标签"按钮点击
    func addBtnClick(){
        
        // 添加一个"标签按钮"
        let tagButton:XMGTagButton = XMGTagButton()
        tagButton.setTitle(self.textField!.text, forState: UIControlState.Normal)
        tagButton.height = self.textField!.height;
        tagButton.addTarget(self, action: "tagButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView!.addSubview(tagButton)
        self.tagButtons.addObject(tagButton)
        
        // 更新标签按钮的frame
        updateTagButtonFrame()
        
        // 清空textField文字
        self.textField!.text = nil;
        self.addButton.hidden = true
    }

    
    func updateTagButtonFrame(){
        
        // 更新标签按钮的frame
        for var i:Int = 0; i < self.tagButtons.count; i++ {
            let tagButton:XMGTagButton = self.tagButtons[i] as! XMGTagButton;
  
            
            if (i == 0) { // 最前面的标签按钮
                tagButton.x = 0;
                tagButton.y = 0;
            } else { // 其他标签按钮
                let lastTagButton:XMGTagButton = self.tagButtons[i - 1] as! XMGTagButton;
                // 计算当前行左边的宽度
                let leftWidth:CGFloat = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;
 
                // 计算当前行右边的宽度
                let rightWidth:CGFloat = self.contentView!.width - leftWidth;

                if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                    tagButton.y = lastTagButton.y;
                    tagButton.x = leftWidth;
                } else { // 按钮显示在下一行
                    tagButton.x = 0;
                    tagButton.y = CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
                }
            }
        }


        
        // 最后一个标签按钮
        let lastTagButton:XMGTagButton = self.tagButtons.lastObject as! XMGTagButton;
        let leftWidth:CGFloat = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;

        // 更新textField的frame
        if (self.contentView!.width - leftWidth >= textFieldTextWidth()) {
            self.textField!.y = lastTagButton.y;
            self.textField!.x = leftWidth;
        } else {
            self.textField!.x = 0;
            self.textField!.y = CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
        }
    }
    /// 标签按钮的点击
    func tagButtonClick(tagButton:XMGTagButton){
        
        tagButton.removeFromSuperview()
        self.tagButtons.removeObject(tagButton)
        // 重新更新所有标签按钮的frame
        weak var weakSelf = self

        UIView.animateWithDuration(0.25, animations: { () -> Void in
            if let weakSelf = weakSelf {
                
            weakSelf.updateTagButtonFrame()
            }

            }, completion: nil)

    }

    /// textField的文字宽度
    func textFieldTextWidth()->CGFloat{
    
        let textW:CGFloat = (self.textField!.text! as NSString).sizeWithAttributes([NSFontAttributeName:self.textField!.font!]).width

        return max(100, textW);
        
    }


}
