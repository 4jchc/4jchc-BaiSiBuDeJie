//
//  XMGKeyboardTool.swift
//  4jchc-键盘处理
//
//  Created by 蒋进 on 16/2/18.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
/** 枚举 */
enum XMGKeyboardToolItem {
    case Previous
    case Next
    case Done
    
}

/** 代理 */
protocol XMGKeyboardToolDelegate:NSObjectProtocol{
    
    func keyboardTool(tool:XMGKeyboardTool,didClickItem:XMGKeyboardToolItem)
    
}

class XMGKeyboardTool: UIToolbar {
    
    //A.2初始化代理协议一定要加上weak, 避免循环引用
    weak var toolbarDelegate:XMGKeyboardToolDelegate?
    
    @IBOutlet weak var nextItem: UIBarButtonItem!
    @IBOutlet weak var previousItem: UIBarButtonItem!

    
    class func tool()->XMGKeyboardTool{
        
        return NSBundle.mainBundle().loadNibNamed("XMGKeyboardTool", owner: nil, options: nil).first as! XMGKeyboardTool
        
    }
    
    @IBAction func previous(sender: AnyObject) {
        if ((self.toolbarDelegate?.respondsToSelector("keyboardTool:didClickItem")) != nil){
            
            print("previous****")
        }
        self.toolbarDelegate?.keyboardTool(self, didClickItem: XMGKeyboardToolItem.Previous)
    }
    
    
    @IBAction func next(sender: AnyObject) {
        if ((self.toolbarDelegate?.respondsToSelector("keyboardTool:didClickItem")) != nil){
            
            print("next****")
        }
        self.toolbarDelegate?.keyboardTool(self, didClickItem: XMGKeyboardToolItem.Next)
    }
    
    
    @IBAction func done(sender: AnyObject) {
        if ((self.toolbarDelegate?.respondsToSelector("keyboardTool:didClickItem")) != nil){
            
            print("done****")
        }
        self.toolbarDelegate?.keyboardTool(self, didClickItem: XMGKeyboardToolItem.Done)
    }
    
    
}
