//
//  UIColor+Extension.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/1.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

///*****✅随机颜色color
extension UIColor {
    
//    class func randomColor() -> UIColor {
//        /*
//        颜色有两种表现形式 RGB RGBA
//        RGB 24
//        R,G,B每个颜色通道8位
//        8的二进制 255
//        R,G,B每个颜色取值 0 ~255
//        120 / 255.0
//        */
//        let r:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        let g:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        let b:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        
//        return UIColor(red: r, green: g, blue: b, alpha: 1)
//    }
    
    //MARK: - 随机色
    ///  随机色
    static var randomColor:UIColor{
        get{
            return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber() , alpha: 1.0)
        }
    }
    
//    class func randomColor() -> UIColor {
//        return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber() , alpha: 1.0)
//    }
    
    class func randomNumber() -> CGFloat {
        // 0 ~ 255
        return CGFloat(arc4random_uniform(256)) / CGFloat(255)
    }
    
    
    //UIColor(red: <#123#>/255.0, green: <#123#>/255.0, blue: <#123#>/255.0, alpha: 1.0)
    //MARK: - RGB色
    ///  RGB色
    class func RGB(r:CGFloat,_ g:CGFloat, _ b:CGFloat, _ alpha:CGFloat = 1.0)->UIColor{
        
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
    }
    
    //MARK:  绿巨人
    ///  绿巨人
    static func greenMain() -> UIColor {
        return UIColor(red: (76/255.0), green: (217/255.0), blue: (100/255.0), alpha: 1.0)
    }
    
    static func redMain() -> UIColor {
        return UIColor(red: (255/255.0), green: (42/255.0), blue: (38/255.0), alpha: 1.0)
    }
    //MARK:  Global整体的Tint
    ///  Global整体的Tint
    func setupAsGlobalTint() {
        // global tint in File inspector seems to have a no effect
        UIView.appearance().tintColor = self
    }
    
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00ff00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000ff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    

    public convenience init(hex: String, alpha: CGFloat) {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
        if (cString.hasPrefix("#")) {
            
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
        else {
            
            var rgbValue:UInt32 = 0
            NSScanner(string: cString).scanHexInt(&rgbValue)
            
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        }
    }
    
 
    
}


public extension UIColor {
    
    public var lighterColor: UIColor {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
        } else {
            assert(false, "Unable to get lighter color for color: \(self)")
            return self
        }
    }
    
    public var darkerColor: UIColor {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r - 0.2, 1.0), green: min(g - 0.2, 1.0), blue: min(b - 0.2, 1.0), alpha: a)
        } else {
            assert(false, "Unable to get lighter color for color: \(self)")
            return self
        }
    }
    
}






import Foundation


extension UIColor {
    //MARK: - Lilac 紫丁香(淡紫色);adj.淡紫色的
    /// Lilac 紫丁香(淡紫色);adj.淡紫色的
    class func wishesLilac() -> UIColor {
        // light purple
        return UIColor(red: 186.0/255.0, green: 164.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    }
    
    class func wishesPurple() -> UIColor {
        // dark purple
        return UIColor(red: 59.0/255.0, green: 32.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    }
    
    class func wishesWhite() -> UIColor {
        // plain white
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    class func wishesGray() -> UIColor {
        // gray
        return UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    }
    
    class func wishesGrayLight() -> UIColor {
        // gray
        return UIColor(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0)
    }
    
    class func wishesPink() -> UIColor {
        // pink
        return UIColor(red: 248.0/255.0, green: 106.0/255.0, blue: 162.0/255.0, alpha: 1.0)
    }
    
    class func wishesYellow() -> UIColor {
        // yellow
        return UIColor(red: 248.0/255.0, green: 184.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    }
}

extension UIColor {
    func colorByChangingRed(redChange: CGFloat, greenChange: CGFloat, blueChange: CGFloat, alphaChange: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0.0)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        rgba[0] = min(max(rgba[0] + redChange, 0.0), 1.0)
        rgba[1] = min(max(rgba[1] + greenChange, 0.0), 1.0)
        rgba[2] = min(max(rgba[2] + blueChange, 0.0), 1.0)
        rgba[3] = min(max(rgba[3] + alphaChange, 0.0), 1.0)
        
        return UIColor(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var hexValue: CUnsignedLongLong = 0
        
        let scanner = NSScanner(string: hexString)
        
        scanner.scanLocation = 1
        
        if scanner.scanHexLongLong(&hexValue) {
            red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255
            blue  = CGFloat(hexValue & 0x0000FF) / 255
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



