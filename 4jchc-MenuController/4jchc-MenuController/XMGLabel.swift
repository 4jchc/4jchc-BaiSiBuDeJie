//
//  XMGLabel.swift
//  4jchc-MenuController
//
//  Created by 蒋进 on 16/3/2.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGLabel: UILabel {


    override func awakeFromNib(){
        super.awakeFromNib()
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
       
    }

    func setup(){
        
        self.userInteractionEnabled = true
        
    }


    /// 让label有资格成为第一响应者
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    

    /**
     * label能执行哪些操作(比如copy, paste等等)
     * @return  YES:支持这种操作
     */
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        return false
    }
    
    
    /*
    /**
    * label能执行哪些操作(比如copy, paste等等)
    * @return  YES:支持这种操作
    */
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    
    if (action == Selector("cut:") || action == Selector("copy:") || action == Selector("copy:") || action == Selector("paste:")) {
    
    return true
    }
    return false
    }
    
    func labelClick(){
    // 1.label要成为第一响应者(作用是:告诉UIMenuController支持哪些操作, 这些操作如何处理)
    self.becomeFirstResponder()
    // 2.显示MenuController
    let menu:UIMenuController = UIMenuController.sharedMenuController()
    //var copyLink = UIMenuItem(title: "", action: Selector("copy:"))
    //UIMenuController.sharedMenuController().menuItems = NSArray(object:copyLink)
    // targetRect: MenuController需要指向的矩形框
    // targetView: targetRect会以targetView的左上角为坐标原点
    menu.setTargetRect(self.frame, inView: self.superview!)
    
    menu.setMenuVisible(true, animated: true)
    }
    
    // 将自己的文字复制到粘贴板
    override func copy(menu: AnyObject?) {
    let pboard = UIPasteboard.generalPasteboard()
    pboard.string = self.text
    }
    
    // 将自己的文字复制到粘贴板
    override func cut(sender: AnyObject?) {
    // 将自己的文字复制到粘贴板
    copy(sender)
    // 清空文字
    self.text = nil
    }
    
    override func paste(sender: AnyObject?) {
    // 将粘贴板的文字 复制 到自己身上
    let pboard = UIPasteboard.generalPasteboard()
    self.text = pboard.string
    }

    */
    



}
