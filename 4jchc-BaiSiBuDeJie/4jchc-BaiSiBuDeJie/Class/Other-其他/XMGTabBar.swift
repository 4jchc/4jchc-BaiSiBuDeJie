//
//  XMGTabBar.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTabBar: UITabBar {
    
    var plusBtn:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置tabbar的背景图片
        self.backgroundImage = UIImage(named: "tabbar-light")
        // 添加一个按钮到tabbar中
        let plusBtn:UIButton = UIButton()
        plusBtn.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: UIControlState.Normal)
        plusBtn.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState: UIControlState.Highlighted)
        plusBtn.addTarget(self, action: "plusClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(plusBtn)
        self.plusBtn = plusBtn
        
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //#warning [super layoutSubviews] 一定要调用
        super.layoutSubviews()
        
        // 1.设置加号按钮的位置
        plusBtn.frame.size = plusBtn.currentBackgroundImage!.size;
        self.plusBtn.center.x = self.width * 0.5;
        self.plusBtn.center.y = self.height * 0.5;
        
        // 2.设置其他tabbarButton的位置和尺寸
        let tabbarButtonW:CGFloat = self.width / 5
        
        var tabbarButtonIndex:CGFloat = 0
        
        for child in self.subviews{
            let Class:AnyClass = NSClassFromString("UITabBarButton")!
            
            //if (!child.isKindOfClass(Class)) {continue}
            //if (!child.isKindOfClass(UIControl.self) || child == plusBtn) {continue}
            if child.isKindOfClass(Class) {
                
                // 设置宽度
                child.width = tabbarButtonW;
                // 设置x
                child.x = tabbarButtonIndex * tabbarButtonW;
                
                // 增加索引
                tabbarButtonIndex++;
                if (tabbarButtonIndex == 2) {
                    tabbarButtonIndex++;
                }
            }/*
            if item.isKindOfClass(NSClassFromString("UITabBarButton")!){
            
            item.frame = CGRect(x: width * (buttonIndex > 1 ? buttonIndex + 1 : buttonIndex), y: 0, width: width, height: item.frame.height)
            
            buttonIndex++
            
            }*/
        }
    }
    func plusClick(){
        
        
    }
}
