//
//  XMGTabBar.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTabBar: UITabBar {
    
    var publishButton:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置tabbar的背景图片
        self.backgroundImage = UIImage(named: "tabbar-light")
        // 添加一个按钮到tabbar中
        let publishButton:UIButton = UIButton()
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: UIControlState.Normal)
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState: UIControlState.Highlighted)
        publishButton.addTarget(self, action: "publishClick", forControlEvents: UIControlEvents.TouchUpInside)
        //TODO: 加号尺寸放在这里不行
        //publishButton.size = publishButton.currentBackgroundImage!.size;
        self.addSubview(publishButton)
        self.publishButton = publishButton
        
        
    }
    
    func publishClick(){
        
        //拿到根控制器来弹出控制器
        let publish = XMGPublishViewController()
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(publish, animated: true, completion: nil)
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        /*
        if item.isKindOfClass(NSClassFromString("UITabBarButton")!){
        
        item.frame = CGRect(x: width * (buttonIndex > 1 ? buttonIndex + 1 : buttonIndex), y: 0, width: width, height: item.frame.height)
        
        buttonIndex++
        
        }*/
        
        
        
        
    override func layoutSubviews() {
        super.layoutSubviews()
        // 标记按钮是否已经添加过监听器
        var added: Bool = false
        let width:CGFloat = self.width;
        let height:CGFloat = self.height;

        // 设置发布按钮的frame
        self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
        publishButton.size = publishButton.currentBackgroundImage!.size;
        // 设置其他UITabBarButton的frame
        let buttonY:CGFloat = 0
        let buttonW:CGFloat = width / 5;
        let buttonH:CGFloat = height
        var index: Int = 0
        for button in self.subviews{

            if !button.isKindOfClass(UIControl.self) || button == self.publishButton {

                continue
            }
            // 计算按钮的x值
            let buttonX:CGFloat = buttonW * CGFloat(((index > 1) ? (index + 1) : index))
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

            // 增加索引
            index++;
            if (added == false) {
                let button = button as? UIControl
                // 监听按钮点击
                button!.addTarget(self, action: "buttonClick", forControlEvents: .TouchUpInside)
            }
        }
        
        added = true
        
    }
    
        func buttonClick(){
            // 发出一个通知
            XMGNoteCenter.postNotificationName(XMGTabBarDidSelectNotification, object: self, userInfo: nil)
            printLog("发出通知")
        }
        
}
