//
//  NSDate+Extension.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/22.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


//MARK: - 微博版时间设置
extension NSDate{
    
    
    //MARK: - 判断是否为- 今年
    ///  判断是否为- 今年
    func isThisYear()->Bool{
        let calendar: NSCalendar  = NSCalendar.currentCalendar()
        // 获得的年月日时分秒
        let dateCmps: NSDateComponents  = calendar.components(NSCalendarUnit.Year, fromDate:self)
        
        let nowCmps: NSDateComponents  = calendar.components(NSCalendarUnit.Year, fromDate: NSDate())

        return dateCmps.year == nowCmps.year;
        
        //        let  year =   calendar.component(.Year, fromDate: self)
        //        let nowYear = calendar.component(.Year, fromDate: NSDate())
        //        return year == nowYear
        
    }
    
    
    //MARK: - 判断是否为- 昨天
    ///  判断是否为- 昨天
    func isYesterday() ->Bool{
        var now: NSDate  = NSDate()
        
        // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
        // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
        let fmt: NSDateFormatter = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd";
        // 2014-04-30
        let dateStr: NSString  = fmt.stringFromDate(self)
        // 2014-10-18
        let nowStr: NSString  = fmt.stringFromDate(now)
        
        // 2014-10-30 00:00:00
        let date: NSDate = fmt.dateFromString(dateStr as String)!
        // 2014-10-18 00:00:00
        now = fmt.dateFromString(nowStr as String)!
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day]
        let cmps: NSDateComponents  = calendar.components(unit, fromDate: date, toDate: now, options: NSCalendarOptions())
        
        return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
        /*
        let nowDate = NSDate().dateWithYMD()
        
        let selfDate = self.dateWithYMD()
        
        // 获得nowDate和selfDate的差距
        let calendar = NSCalendar.currentCalendar()
        let cmps = calendar.components(NSCalendarUnit.Day, fromDate: selfDate, toDate: nowDate, options: NSCalendarOptions.WrapComponents)
        return cmps.day == 1;
        */
    }
    
    
    //MARK: - 判断是否为- 今天
    ///  判断是否为- 今天
    func isToday()->Bool
    {
        let now: NSDate  = NSDate()
        let fmt: NSDateFormatter  = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd";
        // 2014-04-30
        let dateStr: NSString  = fmt.stringFromDate(self)
        // 2014-10-18
        let nowStr: NSString  = fmt.stringFromDate(now)

        return dateStr.isEqualToString(nowStr as String)
        /*
        let calendar = NSCalendar.currentCalendar()
        
        let unitFlags: NSCalendarUnit = [.Year, .Day, .Month]
        
        // 1.获得当前时间的年月日
        let nowCmps = calendar.components(unitFlags, fromDate: NSDate())
        
        // 2.获得self的年月日
        let selfCmps = calendar.components(unitFlags, fromDate: self)
        return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
        */
    }
    
    
    //MARK:  - 获取与当前时间的差距
    ///  获取与当前时间的差距
    func deltaWithNow() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        
        return calendar.components([.Year,.Month,.Day,.Hour,.Minute,.Second], fromDate: self, toDate: NSDate(), options: NSCalendarOptions.WrapComponents)
    }
    
    
    //MARK:  返回一个只有年月日的时间
    ///  返回一个只有年月日的时间
    func dateWithYMD() -> NSDate {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let selfStr = fmt.stringFromDate(self)
        return fmt.dateFromString(selfStr)!
    }
    
    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     NS Calendar-日历
     */
     //MARK: - 时间描述-刚刚-X分钟前-X小时前-昨天
     ///  时间描述-刚刚-X分钟前-X小时前-昨天
    var descriptionDate:String{
        
        let calendar = NSCalendar.currentCalendar()
        
        // 1.判断是否是今天
        if calendar.isDateInToday(self)// @available(iOS 8.0, *)
        {
            // 1.0获取当前时间和系统时间之间的差距(秒数)
            let since = Int(NSDate().timeIntervalSinceDate(self))
            // 1.1是否是刚刚
            if since < 60
            {
                return "刚刚"
            }
            // 1.2多少分钟以前
            if since < 60 * 60
            {
                return "\(since/60)分钟前"
            }
            
            // 1.3多少小时以前
            return "\(since / (60 * 60))小时前"
        }
        
        // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self)
        {
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
        }else
        {
            // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
            // 4.处理更早时间
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comps.year >= 1
            {
                formatterStr = "yyyy-" + formatterStr
            }
        }
        
        // 5.按照指定的格式将时间转换为字符串
        // 5.1.创建formatter
        let formatter = NSDateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 5.4格式化
        
        return formatter.stringFromDate(self)
    }
    //MARK: - 时间描述-刚刚-X分钟前-X小时前-昨天
    ///  时间描述-刚刚-X分钟前-X小时前-昨天
    class func descriptionDate(created_at: String) ->String{
        
        
        let fmt = NSDateFormatter()
        //fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //微博发布的具体时间
        let createDate: NSDate = fmt.dateFromString(created_at)!
        
        //判断是否为今年
        if createDate.isThisYear() == true {
            
            //今天
            if createDate.isToday() == true {
                let cmps =  createDate.deltaWithNow()
                if cmps.hour >= 1 { //至少1小时前
                    return "\(cmps.hour)小时前"
                } else if (cmps.minute >= 1) {//1小时内
                    return "\(cmps.minute)分钟前"
                } else { //1分钟内
                    return "刚刚"
                }
                
            } else if createDate.isYesterday() == true { //昨天
                fmt.dateFormat = "昨天 HH:mm"
                return fmt.stringFromDate(createDate)
            } else { //至少是前天
                fmt.dateFormat = "MM-dd"
                return fmt.stringFromDate(createDate)
            }
            
        } else {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            return fmt.stringFromDate(createDate)
        }
        
    }
    
    
    //MARK: - 将- 时间字符串转换为-NSDate
    ///  将- 时间字符串转换为-NSDate
    class func dateWithStr(time: String) ->NSDate {
        
        // 1.1.创建formatter
        let formatter = NSDateFormatter()
        // 1.2.设置时间的格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 1.4转换字符串, 转换好的时间是去除时区的时间
        let createdDate = formatter.dateFromString(time)!
        
        return createdDate
    }
    
    
}

extension String {
    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     NS Calendar-日历
     */
     //MARK: - 时间描述-刚刚-X分钟前-X小时前-昨天
     ///  时间描述-刚刚-X分钟前-X小时前-昨天
    func descriptionDate()->String {
        
        /* @available(iOS 8.0, *)
        let fmt = NSDateFormatter()
        //fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //微博发布的具体时间
        let createDate: NSDate = fmt.dateFromString(self)!
        
        let calendar = NSCalendar.currentCalendar()
        // 1.判断是否是今天
        if calendar.isDateInToday(createDate)// @available(iOS 8.0, *)
        {
        // 1.0获取当前时间和系统时间之间的差距(秒数)
        let since = Int(NSDate().timeIntervalSinceDate(createDate))
        // 1.1是否是刚刚
        if since < 60
        {
        return "刚刚"
        }
        // 1.2多少分钟以前
        if since < 60 * 60
        {
        return "\(since/60)分钟前"
        }
        
        // 1.3多少小时以前
        return "\(since / (60 * 60))小时前"
        }
        
        // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(createDate)
        {
        // 昨天: HH:mm
        formatterStr =  "昨天:" +  formatterStr
        }else
        {
        // 3.处理一年以内
        formatterStr = "MM-dd " + formatterStr
        
        // 4.处理更早时间
        let comps = calendar.components(NSCalendarUnit.Year, fromDate: createDate, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        if comps.year >= 1
        {
        formatterStr = "yyyy-" + formatterStr
        }
        }
        
        // 5.按照指定的格式将时间转换为字符串
        // 5.1.创建formatter
        let formatter = NSDateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 5.4格式化
        
        return formatter.stringFromDate(createDate)
        }
        
        */
        let fmt = NSDateFormatter()
        //fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //微博发布的具体时间
        let createDate: NSDate = fmt.dateFromString(self)!
        
        //判断是否为今年
        if createDate.isThisYear() == true {
            
            //今天
            if createDate.isToday() == true {
                let cmps =  createDate.deltaWithNow()
                if cmps.hour >= 1 { //至少1小时前
                    return "\(cmps.hour)小时前"
                } else if (cmps.minute >= 1) {//1小时内
                    return "\(cmps.minute)分钟前"
                } else { //1分钟内
                    return "刚刚"
                }
                
            } else if createDate.isYesterday() == true { //昨天
                fmt.dateFormat = "昨天 HH:mm"
                return fmt.stringFromDate(createDate)
            } else { //至少是前天
                fmt.dateFormat = "MM-dd"
                return fmt.stringFromDate(createDate)
            }
            
        } else {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            return fmt.stringFromDate(createDate)
        }
        
    }
    
}

//MARK: - 转换为基本数据类型
extension String{
    
    /**
     将String类型转换转换为Int类型
     
     - Parameter N/A
     - Returns:Int    String转换后的Int值
     */
    func toInt()->Int{
        return Int(self.toDouble())
    }
    /**
     将String类型转换转换为CGFloat类型
     
     - Parameter N/A
     - Returns:CGFloat    String转换后的CGFloat值
     */
    func toCGFloat()->CGFloat{
        return CGFloat(self.toDouble())
    }
    /**
     将String类型转换转换为Double类型
     
     - Parameter N/A
     - Returns:Double    String转换后的Double值
     */
    func toDouble()->Double{
        let lValue=Double(self)
        if (lValue != nil){
            return lValue!
        }else{
            return 0
        }
    }
    //MARK:  将新字符串按路径的方式拼接到原字符串上，即字符串直接添加'/'字符
    /**
    将新字符串按路径的方式拼接到原字符串上，即字符串直接添加'/'字符
    
    - Parameter str:String 要拼接上的字符串
    - Returns:N/A
    */
    func stringByAppendingPathComponent(str:String) -> String{
        
        return self.stringByAppendingFormat("/%@", str)
    }
}
