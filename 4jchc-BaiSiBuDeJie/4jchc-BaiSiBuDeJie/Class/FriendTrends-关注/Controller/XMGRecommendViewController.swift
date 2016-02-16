//
//  XMGRecommendViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
// Recommend推荐 ViewController
import SVProgressHUD

class XMGRecommendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 显示指示器
        SVProgressHUD.showInfoWithStatus("正在加载...", maskType: SVProgressHUDMaskType.Black)
        // 发送请求
        // 1.定义URL路径
        let path = "oauth2/access_token"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "category";
        params["c"] = "subscribe";
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 隐藏指示器
            SVProgressHUD.dismiss()
            
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
