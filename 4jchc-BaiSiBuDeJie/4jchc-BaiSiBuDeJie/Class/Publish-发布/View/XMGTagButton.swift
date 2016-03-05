//
//  XMGTagButton.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/5.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTagButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named:"chose_tag_close_icon"), forState: UIControlState.Normal)
        self.backgroundColor = XMGTagBg;
        self.titleLabel!.font = XMGTagFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        self.sizeToFit()
        self.width += 3 * XMGTagMargin;
        self.height = XMGTagH;
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel!.x = XMGTagMargin;
        self.imageView!.x = CGRectGetMaxX(self.titleLabel!.frame) + XMGTagMargin;
    }
    

}
