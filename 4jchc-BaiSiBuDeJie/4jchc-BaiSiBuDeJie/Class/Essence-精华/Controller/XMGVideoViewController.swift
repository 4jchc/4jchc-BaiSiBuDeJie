//
//  XMGVideoViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/20.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGVideoViewController: XMGTopicViewController {
        
        
    //存储属性重写要实现get和set方法写成计算实现类型
    override var type:String{
        get{
            return "41"
        }
        set{
            self.type = newValue
        }
        
    }
}