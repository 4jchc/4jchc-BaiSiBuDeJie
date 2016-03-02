//
//  ViewController.swift
//  4jchc-MenuController
//
//  Created by 蒋进 on 16/3/2.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: XMGLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: ("labelClick"))
        self.label.addGestureRecognizer(tap)
    }

    
    func labelClick(){
        // 1.label要成为第一响应者(作用是:告诉UIMenuController支持哪些操作, 这些操作如何处理)
        self.label.becomeFirstResponder()
        // 2.显示MenuController
        
        let menu:UIMenuController = UIMenuController.sharedMenuController()
        // 添加MenuItem
        if menu.menuVisible == true{
            
            menu.setMenuVisible(false, animated: true)
        }else{
            
            let ding = UIMenuItem(title: "复制", action: Selector("ding:"))
            let replay = UIMenuItem(title: "剪切", action: Selector("replay:"))
            let report = UIMenuItem(title: "粘贴", action: Selector("report:"))
            
            menu.menuItems = [ding, replay, report]
            // targetRect: MenuController需要指向的矩形框
            // targetView: targetRect会以targetView的左上角为坐标原点
            //let rect:CGRect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
            menu.setTargetRect(self.label.frame, inView: self.label.superview!)
            
            menu.setMenuVisible(true, animated: true)
        }
        

    }
    
    // 将自己的文字复制到粘贴板
     func ding(menu: AnyObject?) {
        let pboard = UIPasteboard.generalPasteboard()
        pboard.string = self.label.text
    }
    
    // 将自己的文字复制到粘贴板
     func replay(sender: AnyObject?) {
        // 将自己的文字复制到粘贴板
        copy(sender)
        // 清空文字
        self.label.text = nil
    }
    
     func report(sender: AnyObject?) {
        // 将粘贴板的文字 复制 到自己身上
        let pboard = UIPasteboard.generalPasteboard()
        self.label.text = pboard.string
    }
    
}

