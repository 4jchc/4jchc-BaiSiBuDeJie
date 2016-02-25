
//
//  XMGProgressView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/23.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import DACircularProgress
class XMGProgressView: DALabeledCircularProgressView {


    override func awakeFromNib() {
        // 取消自动调整伸缩
        self.autoresizingMask = UIViewAutoresizing.None;
        self.roundedCorners = 2;
        self.progressLabel.textColor = UIColor.redColor()
    }
    override func setProgress(progress: CGFloat, animated: Bool) {
        super.setProgress(progress, animated: animated)
        let text:NSString = String(format: "%.0f%%", progress * CGFloat(100))
        // 替换
        progressLabel.text = text.stringByReplacingOccurrencesOfString("-", withString: "")
    }
    


}
