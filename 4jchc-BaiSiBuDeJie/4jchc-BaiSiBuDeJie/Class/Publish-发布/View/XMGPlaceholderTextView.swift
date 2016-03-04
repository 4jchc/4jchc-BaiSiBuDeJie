//
//  XMGPlaceholderTextView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGPlaceholderTextView: UITextView {


    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = true
        
        // 默认字体
        self.font = UIFont.systemFontOfSize(15)
        // 默认的占位文字颜色
        self.placeholderColor = UIColor.grayColor()
        // 监听文字改变
        XMGNoteCenter.addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 绘制占位文字(每次drawRect:之前, 会自动清除掉之前绘制的内容)
    override func drawRect(rect: CGRect) {
        // Drawing code
        // 如果有文字, 直接返回, 不绘制占位文字
        //    if (self.text.length || self.attributedText.length) return;
        if (self.hasText()) {return}
        
        var rect: CGRect = rect
        // 处理rect
        rect.origin.x = 4;
        rect.origin.y = 7;
        rect.size.width -= 2 * rect.origin.x;
        
        // 文字属性
        var attrs=[String:AnyObject]()
        attrs[NSFontAttributeName] = self.font;
        attrs[NSForegroundColorAttributeName] = self.placeholderColor;
        self.placeholder?.drawInRect(rect, withAttributes: attrs)
        
    }
    

    deinit{
        XMGNoteCenter.removeObserver(self)
    }
    ///: 监听文字改变
    func textDidChange(){
        
        setNeedsDisplay()
    }

    //MARK: 重写setter
    var placeholderColor:UIColor?{
        
        didSet{
            
            setNeedsDisplay()
        }
    }

    var placeholder:NSString?{
        
        didSet{
            
            setNeedsDisplay()
        }
    }
    
    override var font:UIFont?{
        
        didSet{
            super.font = font
            setNeedsDisplay()
        }
    }
    
    override var text:String?{
        
        didSet{
            
            super.text = text
            setNeedsDisplay()
        }
    }
    override var attributedText: NSAttributedString?{
        
        didSet{
            
            super.attributedText = attributedText
            setNeedsDisplay()
        }
    }

}
