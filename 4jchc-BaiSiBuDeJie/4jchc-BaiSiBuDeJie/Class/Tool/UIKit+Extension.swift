//
//  UIKit.swift
//  4jchc-Extension
//
//  Created by 蒋进 on 15/12/26.
//  Copyright © 2015年 sijichcai. All rights reserved.
//
import Foundation
import UIKit


//MARK: - 弧度
///弧度
func radians(degrees:CGFloat) ->CGFloat {
    
    return ( degrees * 3.14159265 ) / 180.0;
    
}

//MARK: - 延迟在主线程执行函数
///  延迟在主线程执行函数
///
/// - parameter delta:    延迟时间
/// - parameter callFunc: 要执行的闭包方法
func delay(delta: Double, callFunc: ()->()) {
    
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, Int64(delta * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue()) {
            
            callFunc()
    }
}


//MARK: - 自定义在DEBUG下的打印print
/// 自定义的DEBUG下的打印print
//MARK: - 在 BuildSettting 中 搜索 other swift flags 里DEBUG项
//MARK: 而不是在主的列表添加,那样release也添加了 `-D DEBUG`

/**
 - parameter message: 需要输入的信息
 - parameter file:    文件名
 - parameter method:  调用print的方法
 - parameter line:    打印函数 所在的行号
 */

func printLog<T>(message: T,
    file: String = __FILE__,
    method: String = __FUNCTION__,
    line: Int = __LINE__)
{
    #if DEBUG
        __LINE__
        print("\((file as NSString).lastPathComponent)[\(line)行], \(method): 💗\(message)")
    #else
        //print("\(message)")
        
    #endif

}



class WBLog{
    static func Log(message:String){
        #if DEBUG
            NSLog(message)
        #endif
    }
    
    static func Log(format: String, args: CVarArgType){
        #if DEBUG
            NSLog(format, args)
        #endif
    }
}



