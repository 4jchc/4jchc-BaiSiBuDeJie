//
//  NetworkTools.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//


import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let tools:NetworkTools = {
        // 注意: baseURL一定要以/结尾
        let url = NSURL(string: "http://api.budejie.com/")
        let t = NetworkTools(baseURL: url)
        
        // 设置AFN能够接收得数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return t
    }()
    
    /// 获取单粒的方法
    class func shareNetworkTools() -> NetworkTools {
        return tools
    }
    
    
    func sendGET(url:String,params:AnyObject?,successCallback: (responseObject:AnyObject) -> (),errorCallback:(error:NSError) -> ()){
        
        
        // 2.发送请求
        assert(NetworkTools.shareNetworkTools() == self, "应该相等")
        
        self.GET(url, parameters: params, progress: { (progress) -> Void in} ,success: { (_, responseObject) -> Void in
            
            successCallback(responseObject: responseObject!)
            
            }) { (operation, error) -> Void in
                
                errorCallback(error: error)
        }
    }
    
    
    
    
    func sendPOST(url:String,params:AnyObject?,successCallback: (responseObject:AnyObject) -> Void,errorCallback:(error:NSError) -> Void){
        
        //self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        //mgr.responseSerializer.acceptableContentTypes = NSSet(objects: ["text/plain","application/json","text/json","text/javascript"]) as Set<NSObject>
        //responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json","text/json","text/javascript"])as Set<NSObject>
        // 2.发送请求
        
        POST(url, parameters: params,progress: { (progress) -> Void in} , success: { (_, responseObject) -> Void in
            
            successCallback(responseObject: responseObject!)
            
            }) { (_, error) -> Void in
                
                errorCallback(error: error)
        }
        
    }
    
    
    
    func sendPOST(url:String,params:AnyObject?,constructingBodyBlock: (formData:AFMultipartFormData) -> Void,successCallback: (responseObject:AnyObject) -> Void,errorCallback:(error:NSError) -> Void){
        
        POST(url, parameters: params!, constructingBodyWithBlock: {(formData: AFMultipartFormData!) in
            
            
            /*
            formData.appendPartWithFileURL(filePath, name: "file", error: nil)
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
            
            */
            constructingBodyBlock(formData: formData!)
            
            },progress: { (progress) -> Void in} , success: { (_, responseObject) -> Void in
                /*
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                vc.presentViewController(responseViewController, animated: true, completion: {
                SVProgressHUD.showSuccessWithStatus("Success")
                })
                */
                
                successCallback(responseObject: responseObject!)
            }) { (_, error) -> Void in
                
                errorCallback(error: error)
        }
        
    }
    
    
}


