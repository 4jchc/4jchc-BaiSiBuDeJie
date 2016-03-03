//
//  UIImageView+Extension.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD
import Foundation
import UIKit

extension UIImageView {
    
    func setHeader(url:String){
        
        let placeholder:UIImage = UIImage(named: "defaultUserIcon")!
        
        
        self.sd_setImageWithURL(NSURL(string: url), placeholderImage: placeholder) { (image, error, cacheType, imageURL) -> Void in
            
            self.image = image != nil ? image.circleImage() : placeholder;
        }
    }
    
}

