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
    /** 工具条 */
    var toolbar:XMGAddTagToolbar?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTextView()
        setupToolbar()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 设置单行文本
    func setupTextView(){
        let textView:XMGPlaceholderTextView = XMGPlaceholderTextView()
        
        textView.frame = self.view.bounds;
        textView.placeholder = "把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
        textView.delegate = self;
        self.view.addSubview(textView)
        self.textView = textView;
    }
    //MARK: 设置导航栏
    func setupNav() {
        
        self.title = "发表文字";
        // 设置导航栏标题
        //self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        
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
    //MARK: 设置键盘工具条
    func setupToolbar(){
        
        let toolbar:XMGAddTagToolbar = XMGAddTagToolbar.viewFromXIB()
        toolbar.width = self.view.width;
        toolbar.y = self.view.height - toolbar.height;
        self.view.addSubview(toolbar)
        self.toolbar = toolbar;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func keyboardWillChangeFrame(note: NSNotification){
        
        // 键盘显示\隐藏完毕的frame
        let keyboardF:CGRect = note.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        // 动画时间
        let duration:Double = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        // 动画 及时刷新
        UIView.animateWithDuration(duration) { () -> Void in
            self.toolbar!.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - XMGScreenH)

        }
    }
    
    func cancel(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func post(){
        
        
    }

    
    
    
    /// 点击别的地方会结束编辑
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 主动召唤键盘
        textView!.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 主动隐藏键盘
        textView!.resignFirstResponder()
    }
    
}
extension  XMGPostWordViewController:UITextViewDelegate{
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        
        self.navigationItem.rightBarButtonItem!.enabled = textView.hasText()

    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)

    }

}
