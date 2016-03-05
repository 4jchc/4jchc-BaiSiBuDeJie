//
//  XMGAddTagToolbar.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGAddTagToolbar: UIView {
    /** 顶部控件 */
    @IBOutlet weak var topView: UIView!
    lazy var tagLabels = NSMutableArray()
    /** 添加按钮 */
    lazy var addButton = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // 添加一个加号按钮
        let button:UIButton = UIButton()
        button.addTarget(self, action: "addButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: "tag_add_icon"), forState: .Normal)
        button.size = button.currentImage!.size;
        button.x = XMGTagMargin;
        self.topView.addSubview(button)
        self.addButton = button;
    }
    func addButtonClick(){
        
        let vc = XMGAddTagViewController()
        weak var weakSelf = self
        vc.tagsBlock = {
            (tags) in
            if let weakSelf = weakSelf {
               
                weakSelf.createTagLabels(tags)
                
            }
        }
        vc.tags = self.tagLabels.valueForKeyPath("text") as! NSArray

        // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
        let root:UIViewController = UIApplication.sharedApplication().keyWindow!.rootViewController!
        let nav = root.presentedViewController as? UINavigationController
        nav?.pushViewController(vc, animated: true)

    }
    func createTagLabels(tags:NSArray){
        
        self.tagLabels.forEach({$0.removeFromSuperview()})
        self.tagLabels.removeAllObjects()
        for var i:Int = 0; i < tags.count; i++ {
            let tagLabel:UILabel = UILabel()
            self.tagLabels.addObject(tagLabel)
            tagLabel.font = XMGTagFont;
            tagLabel.backgroundColor = XMGTagBg;
            tagLabel.textAlignment = NSTextAlignment.Center;
            tagLabel.text = tags[i] as? String
            // 应该要先设置文字和字体后，再进行计算
            tagLabel.sizeToFit()
            tagLabel.width += 2 * XMGTagMargin;
            tagLabel.height = XMGTagH;
            tagLabel.textColor = UIColor.whiteColor()
            self.topView.addSubview(tagLabel)

            
            // 设置位置
            if (i == 0) { // 最前面的标签
                tagLabel.x = 0;
                tagLabel.y = 0;
            } else { // 其他标签
                let lastTagLabel:UILabel = self.tagLabels[i - 1] as! UILabel;
                // 计算当前行左边的宽度
                let leftWidth:CGFloat = CGRectGetMaxX(lastTagLabel.frame) + XMGTagMargin;
                
                // 计算当前行右边的宽度
                let rightWidth:CGFloat = self.topView.width - leftWidth;

                if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                    tagLabel.y = lastTagLabel.y;
                    tagLabel.x = leftWidth;
                } else { // 按钮显示在下一行
                    tagLabel.x = 0;
                    tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + XMGTagMargin;
                }
            }

  
        }
        
        if (self.tagLabels.lastObject == nil) { // 最前面的标签按钮
            self.addButton.x = 0;
            self.addButton.y = XMGTagMargin;
            
        }else{
            
            // 最后一个标签
            let lastTagLabel:UILabel = self.tagLabels.lastObject as! UILabel
            let leftWidth:CGFloat = CGRectGetMaxX(lastTagLabel.frame) + XMGTagMargin;
            
            // 更新textField的frame
            if (self.topView.width - leftWidth >= self.addButton.width) {
                self.addButton.y = lastTagLabel.y;
                self.addButton.x = leftWidth;
            } else {
                self.addButton.x = 0;
                self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + XMGTagMargin;
            }
            
        }

 
    }
}
