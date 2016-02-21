//
//  XMGAllViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/20.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJExtension
import MJRefresh
class XMGAllViewController: UITableViewController {
    /** 帖子数据 */
    var topics:NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        /// 初始化表格
        setupTableView()
        
    }
    /// 初始化表格
    func setupTableView() {
        
        // 设置内边距
        let bottom:CGFloat = self.tabBarController!.tabBar.height;
        let top:CGFloat = XMGTitilesViewY + XMGTitilesViewH;
        self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }

    //MARK:   加载左侧的类别数据
    ///   加载左侧的类别数据
    func loadCategories(){
        
        // 显示指示器
        SVProgressHUD.showInfoWithStatus("正在加载...", maskType: SVProgressHUDMaskType.Black)
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()

        params["a"] = "list";
        params["c"] = "data";
        params["type"] = "29";
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            
            // 隐藏指示器
            SVProgressHUD.dismiss()
            // 服务器返回的JSON数据
            self.topics = responseObject["list"] as? NSArray

            // 刷新表格
            self.tableView.reloadData()

            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topics?.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID:String = "contact"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID as String)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }
        cell!.textLabel!.text = String(format: "----%zd",indexPath.row)
        let topic:NSDictionary = self.topics![indexPath.row] as! NSDictionary;
        cell!.textLabel!.text = topic["name"] as? String
        cell!.detailTextLabel!.text = topic["text"] as? String
        cell!.imageView!.sd_setImageWithURL(NSURL(string: topic["profile_image"] as! String), placeholderImage: UIImage(named: "defaultUserIcon"))

        
        return cell!
    }

}
