//
//  XMGTagTextField.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/5.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTagTextField: UITextField {

    
    // 也能在这个方法中监听键盘的输入，比如输入“换行”
    //- (void)insertText:(NSString *)text
    //{
    //    [super insertText:text];
    //
    //    XMGLog(@"%d", [text isEqualToString:@"\n"]);
    //}
    override func insertText(text: String) {
        super.insertText(text)
        
    }

    /** 按了删除键后的回调 */
    //var deleteBlock: (() -> Void)

    var deleteBlock:(() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    self.placeholder = "多个标签用逗号或者换行隔开";
    // 设置了占位文字内容以后, 才能设置占位文字的颜色
    self.setValue(UIColor.greenColor(), forKeyPath: "_placeholderLabel.textColor")
    self.height = XMGTagH;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func deleteBackward() {
        deleteBlock?()
        super.deleteBackward()
    }

}
