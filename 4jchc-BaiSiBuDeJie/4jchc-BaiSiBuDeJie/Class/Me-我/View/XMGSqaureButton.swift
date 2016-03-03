
//
//  XMGSqaureself.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGSqaureButton: UIButton {
    
    func setup(){
        
        self.titleLabel!.textAlignment = NSTextAlignment.Center;
        
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        self.setBackgroundImage(UIImage(named: "mainCellBackground"), forState: .Normal)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        self.imageView!.y = self.height * 0.15;
        self.imageView!.width = self.width * 0.5;
        self.imageView!.height = self.imageView!.width;
        self.imageView!.centerX = self.width * 0.5;
        
        // 调整文字
        self.titleLabel!.x = 0;
        self.titleLabel!.y = CGRectGetMaxY(self.imageView!.frame);
        self.titleLabel!.width = self.width;
        self.titleLabel!.height = self.height - self.titleLabel!.y;
        
    }
    // 通过模型赋值
    var square:XMGSquare?{
        
        didSet{
            self.setTitle(square?.name, forState: .Normal)
            // 利用SDWebImage给按钮设置image
            self.sd_setImageWithURL(NSURL(string: square!.icon!), forState: .Normal)

            
        }
        
    }
    
}
