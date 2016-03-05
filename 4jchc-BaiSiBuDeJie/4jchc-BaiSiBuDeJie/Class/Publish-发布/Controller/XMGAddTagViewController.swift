//
//  XMGAddTagViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/5.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD

class XMGAddTagViewController: UIViewController {
    
    /** 内容 */
    var contentView:UIView?
    /** 文本输入框 */
    var textField:UITextField?
    /** 所有的标签按钮 */
    lazy var tagButtons = NSMutableArray()
    /** 获取tags的block */
    var tagsBlock: ((tags:NSArray) -> Void)?
    
    /** 所有的标签 */
    lazy var tags = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupContentView()
        setupTextFiled()
        setupTags()
        
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
    //MARK: - 初始化
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
        weak var weakSelf = self

        let textField:XMGTagTextField = XMGTagTextField()
        textField.width = self.contentView!.width;
        textField.deleteBlock = {
            
            if let weakSelf = weakSelf {
                
               if weakSelf.textField!.hasText() || weakSelf.tagButtons.lastObject==nil{
                    return
                }
                weakSelf.tagButtonClick(weakSelf.tagButtons.lastObject! as! XMGTagButton)
            }
        
        }
        textField.addTarget(self, action: "textDidChange", forControlEvents: UIControlEvents.EditingChanged)
        textField.becomeFirstResponder()
        textField.delegate = self;
        self.contentView!.addSubview(textField)
        self.textField = textField;
    }
    
    //MARK: 设置导航栏
    func setupNav() {
        // 设置背景色
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "添加标签";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Done, target: self, action: "done")


    }
    //MARK: 设置标签内容
    func setupTags(){
        for attrs in self.tags{
            let attrs = attrs as! String
            self.textField!.text = attrs
            self.addButtonClick()
        }

    }

    ///  监听文字改变
    func textDidChange(){

        if (self.textField!.hasText()) { // 有文字
            // 显示"添加标签"的按钮
            self.addButton.hidden = false
            self.addButton.y = CGRectGetMaxY(self.textField!.frame) + XMGTagMargin;
            self.addButton.setTitle("添加标签:\(self.textField!.text!)", forState: .Normal)
            // 获得最后一个字符
            let text:NSString = self.textField!.text! as NSString
            let len:Int = text.length;
            let lastLetter:NSString = text.substringFromIndex(len-1)
            if lastLetter.isEqualToString(",") || lastLetter.isEqualToString(","){
                
                // 去除逗号
                self.textField!.text =  text.substringToIndex(len-1)
            
                addButtonClick()
            }

            
        } else { // 没有文字
            // 隐藏"添加标签"的按钮
            self.addButton.hidden = true
        }
        // 更新文本框的frame
        updateTextFieldFrame()
    }
    

    
    
    func cancel(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func done(){
        // 传递数据给上一个控制器
//        let tags:NSMutableArray=NSMutableArray()
//        for attrs in self.tagButtons{
//            let attrs = attrs as! XMGTagButton
//            tags.addObject(attrs.currentTitle!)
//        }
        
        // 传递tags给这个block
        let tags:NSArray = self.tagButtons.valueForKeyPath("currentTitle") as! NSArray
        
        
        self.tagsBlock?(tags: tags)
        
        // pop
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    private lazy  var addButton: UIButton = {
        let btn = UIButton()
        btn.width = self.contentView!.width;
        btn.height = 35;
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = XMGTagFont
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, XMGTagMargin, 0, XMGTagMargin);
        // 让按钮内部的文字和图片都左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        btn.backgroundColor = UIColor.RGB(74, 139, 209);
        btn.addTarget(self, action: "addButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView!.addSubview(btn)
        return btn
    }()
    
    //MARK: - 监听按钮点击
    /// 标签按钮的点击
    func tagButtonClick(tagButton:XMGTagButton){
        
        tagButton.removeFromSuperview()
        self.tagButtons.removeObject(tagButton)
        // 重新更新所有标签按钮的frame
        weak var weakSelf = self
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            if let weakSelf = weakSelf {
                
                // 更新标签按钮的frame
                weakSelf.updateTagButtonFrame()
                weakSelf.updateTextFieldFrame()
            }
            
            }, completion: nil)
        
    }
    /// 监听"添加标签"按钮点击
    func addButtonClick(){
        
        if (self.tagButtons.count == 5) {
            SVProgressHUD.showErrorWithStatus("最多添加5个标签!")

            return;
        }
        
        // 添加一个"标签按钮"
        let tagButton:XMGTagButton = XMGTagButton()
        tagButton.setTitle(self.textField!.text, forState: UIControlState.Normal)
        tagButton.addTarget(self, action: "tagButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView!.addSubview(tagButton)
        self.tagButtons.addObject(tagButton)
        
        // 清空textField文字
        self.textField!.text = nil;
        self.addButton.hidden = true
        // 更新标签按钮的frame
        updateTagButtonFrame()
        updateTextFieldFrame()
    }
    //MARK: - 子控件的frame处理
    /// 专门用来更新标签按钮的frame
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
        
    }
    
    /// 更新textField的frame
    func updateTextFieldFrame(){
        
        if (self.tagButtons.lastObject == nil) { // 最前面的标签按钮
            self.textField!.x = 0;
            self.textField!.y = XMGTagMargin;
    
        }else{
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
    }

    
    /// textField的文字宽度
    func textFieldTextWidth()->CGFloat{
        
        let textW:CGFloat = (self.textField!.text! as NSString).sizeWithAttributes([NSFontAttributeName:self.textField!.font!]).width
        
        return max(100, textW);
        
    }
    
    
}
extension  XMGAddTagViewController:UITextFieldDelegate{
    
    /// 监听键盘最右下角按钮的点击（return key， 比如“换行”、“完成”等等）
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.hasText()) {
            
             addButtonClick()
        }
        return true
    }
    
 
}