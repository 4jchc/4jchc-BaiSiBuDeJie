//
//  XMGTextField.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/19.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */
class XMGTextField: UITextField {


    let XMGPlacerholderColorKeyPath = "_placeholderLabel.textColor"
    var placeHodelColor:UIColor?{
        
        didSet{
            
            self.setValue(placeHodelColor, forKeyPath: XMGPlacerholderColorKeyPath)
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置光标颜色和文字颜色一致
        self.tintColor = self.textColor;

        // KVC 设置placeholder字体颜色
        //setValue(UIColor.whiteColor(), forKeyPath: XMGPlacerholderColorKeyPath)
        // KVC 设置光标颜色
        //setValue(UIColor.whiteColor(), forKeyPath: "tintColor")
        
        // 设置textField边框颜色
        layer.borderColor = UIColor.whiteColor().CGColor
        // 设置textField边框的宽度
        layer.borderWidth = 0.1
        // 设置圆角
        layer.cornerRadius = frame.size.height * 0.3
        // 不成为第一响应者
        self.resignFirstResponder()

        }
    

    //MARK:  当前文本框聚焦时就会调用
    override func becomeFirstResponder() -> Bool {
        
        // 修改占位文字颜色
        setValue(self.textColor, forKeyPath: XMGPlacerholderColorKeyPath)
        return super.becomeFirstResponder()
    }
    //MARK:  当前文本框失去焦点时就会调用
    override func resignFirstResponder() -> Bool {
        
        // 修改占位文字颜色

        //setValue(UIColor.redColor(), forKeyPath: "_placeholderLabel.textColor")
        self.setValue(UIColor(white: 0.4, alpha: 0.8), forKeyPath: XMGPlacerholderColorKeyPath)
        return super.resignFirstResponder()
        
    }
    /*
    override func drawPlaceholderInRect(rect: CGRect) {
        super.drawPlaceholderInRect(rect)
        //KVC  KVO   OBSERVER
        self.setValue(UIColor.whiteColor(), forKeyPath: XMGPlacerholderColorKeyPath)
    }
    
    */

}
