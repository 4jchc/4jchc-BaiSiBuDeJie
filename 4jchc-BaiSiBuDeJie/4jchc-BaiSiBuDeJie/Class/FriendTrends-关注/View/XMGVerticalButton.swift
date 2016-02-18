//
//  XMGVerticalButton.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/18.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
//MARK: - 按钮--图片在上-文字在下
class XMGVerticalButton: UIButton {


    func setup(){
        
    self.titleLabel!.textAlignment = NSTextAlignment.Center;
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
        self.imageView!.x = 0;
        self.imageView!.y = 0;
        self.imageView!.width = self.width;
        self.imageView!.height = self.imageView!.width;
        
        // 调整文字
        self.titleLabel!.x = 0;
        self.titleLabel!.y = self.imageView!.height;
        self.titleLabel!.width = self.width;
        self.titleLabel!.height = self.height - self.titleLabel!.y;
    }
    
}
