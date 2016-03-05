//
//  XMGMeFooterView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD


class XMGMeFooterView: UIView {

    static var foothight:CGFloat=CGFloat()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //loadpics()
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "square";
        params["c"] = "topic";
        
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            
            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            let sqaures:NSArray = XMGSquare.mj_objectArrayWithKeyValuesArray(responseObject["square_list"])
            
            self.createSquares(sqaures)
            
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                
                
                
                
        }
        self.backgroundColor = UIColor.clearColor()

    }
    /// 加载更多的帖子数据
    func loadpics(){

        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "square";
        params["c"] = "topic";

        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in

            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            let sqaures:NSArray = XMGSquare.mj_objectArrayWithKeyValuesArray(responseObject["square_list"])

            self.createSquares(sqaures)
            
            }) { (error) -> () in
                    // 显示失败信息
                    SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")

                    
                

        }
    }
    func createSquares(sqaures:NSArray){
        
        // 一行最多4列
        let maxCols:Int = 4
        // 宽度和高度
        let buttonW:CGFloat = XMGScreenW / CGFloat(maxCols)
        let buttonH:CGFloat = buttonW
        for var i:Int = 0; i < sqaures.count; i++ {

            // 创建按钮
            let button = XMGSqaureButton()
            button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            // 传递模型
            button.square = sqaures[i] as? XMGSquare;
            self.addSubview(button)
            // 计算frame
            // 当前的索引
            let col:Int = i % maxCols
            let row:Int = i / maxCols
            
            button.x = CGFloat(col) * buttonW;
            button.y = CGFloat(row) * buttonH;
            button.width = buttonW;
            button.height = buttonH;
        }
        
        // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
        // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
        // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
        
        // 总行数
        //    NSUInteger rows = sqaures.count / maxCols;
        //    if (sqaures.count % maxCols) { // 不能整除, + 1
        //        rows++;
        //    }
        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
        // 当前的索引
        let rows:Int = (sqaures.count + maxCols - 1) / maxCols;

        // 计算footer的高度
        printLog("rows\(rows)-buttonW\(buttonW)")
        //self.height = CGFloat(rows) * buttonH //+ CGFloat(200)
        printLog("height\(self.height)")
        XMGMeFooterView.foothight = CGFloat(rows) * buttonH
        // 重绘
        self.setNeedsDisplay()
    }
    func buttonClick(button:XMGSqaureButton){
        
        if !button.square!.url!.hasPrefix("http") || button.square?.url == nil {
            return
        }
        let web:XMGWebViewController = XMGWebViewController()
        web.url = button.square!.url;
        web.title = button.square!.name;
        
        // 取出当前UITabBarController所在的导航控制器
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
        let tabBarVc:UITabBarController = window.rootViewController as! UITabBarController
        let nav:UINavigationController = tabBarVc.selectedViewController as! UINavigationController
        
        nav.pushViewController(web, animated: true)

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
