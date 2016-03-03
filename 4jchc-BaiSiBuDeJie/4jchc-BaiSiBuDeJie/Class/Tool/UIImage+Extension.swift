//
//  UIImage+Extension.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//
import Foundation
import UIKit
extension UIImage {
    
    
    //MARK:  根据网络图片的地址下载图片并且返回圆形的剪裁图片
    ///  根据网络图片的地址下载图片并且返回圆形的剪裁图片
    class    func circleImageWithImageURL(image_url:String)->UIImage?{
        //下载网络图片
        let data = NSData(contentsOfURL: NSURL(string: image_url)!)
        let olderImage = UIImage(data: data!)
        //开启图片上下文
        let contextW = olderImage?.size.width
        let contextH = olderImage?.size.height
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW!,contextH! ), false, 0.0);
        //画小圆
        let ctx=UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(ctx, CGRect(x: 0, y: 0, width: contextW!, height: contextH!))
        CGContextClip(ctx)
        olderImage?.drawInRect(CGRect(x: 0, y: 0, width: contextW!, height: contextH!))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func circleImage()->UIImage{
        
        // NO代表透明
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        // 获得上下文
        let ctx = UIGraphicsGetCurrentContext()

        // 添加一个圆
        let rect:CGRect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextAddEllipseInRect(ctx, rect);
        
        // 裁剪
        CGContextClip(ctx);
        
        // 将图片画上去
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return newImage;
    }
}




