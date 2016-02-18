//
//  ViewController.swift
//  4jchc-键盘处理
//
//  Created by 蒋进 on 16/2/18.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
// 1. 在SB中添加了UIStackView.所以不可以遍历到子视图
// 2. 数组的索引的取法 self.fields!.indexOfObject(view)
// 3. 如果是一种类型的就通过枚举配合代理来实现传值
class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    
    /** 所有的文本框数组 */
    var fields:NSArray?
    /** 工具条 */
    var toolbar:XMGKeyboardTool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fields = [self.nameField, self.emailField, self.addressField];
        
        // 加载工具条控件
        let toolbar:XMGKeyboardTool = XMGKeyboardTool.tool()
        toolbar.toolbarDelegate = self
        self.toolbar = toolbar;
        
        // 设置工具条
        self.nameField.inputAccessoryView = toolbar;
        self.emailField.inputAccessoryView = toolbar;
        self.addressField.inputAccessoryView = toolbar;
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }



}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    
    //MARK: 当点击键盘右下角的return key时,就会调用这个方法
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == self.nameField) {
            // 让emailField成为第一响应者
            self.emailField.becomeFirstResponder()
            
        } else if (textField == self.emailField) {
            // 让addressField成为第一响应者
            self.addressField.becomeFirstResponder()
            
        } else if (textField == self.addressField) {
            self.view.endEditing(true)
            
            // [textField resignFirstResponder];
        }
        return true
    }
    //MARK: 键盘弹出就会调用这个方法
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let currentIndex:Int = (self.fields?.indexOfObject(textField))!
        
        toolbar!.previousItem.enabled = (currentIndex != 0);
        toolbar!.nextItem.enabled = (currentIndex != self.fields!.count - 1);
    }


}
//MARK: - XMGKeyboardToolDelegate
extension ViewController: XMGKeyboardToolDelegate{
    
    func keyboardTool(tool: XMGKeyboardTool, didClickItem: XMGKeyboardToolItem) {
        
        if (didClickItem == XMGKeyboardToolItem.Previous) {
            var currentIndex:Int = 0
            
            for view in self.view.subviews{
                
                if view.isFirstResponder() {
                    currentIndex = self.fields!.indexOfObject(view)
                 
                }
                
            }
        
        
                currentIndex--
            
                self.fields![currentIndex].becomeFirstResponder()
                self.toolbar!.previousItem.enabled = (currentIndex != 0);
                self.toolbar!.nextItem.enabled = true
            

            
        } else if (didClickItem == XMGKeyboardToolItem.Next) {
            var currentIndex:Int = 0
 
            for view in self.view.subviews{
                if view.isFirstResponder() {
                    currentIndex = self.fields!.indexOfObject(view)
                 
                }

            }
         
                currentIndex++
                self.fields![currentIndex].becomeFirstResponder()
                self.toolbar!.previousItem.enabled = true
                self.toolbar!.nextItem.enabled = (currentIndex != self.fields!.count - 1);
        
        } else if (didClickItem == XMGKeyboardToolItem.Done) {
            
            self.view.endEditing(true)
        }
    }
    
}

