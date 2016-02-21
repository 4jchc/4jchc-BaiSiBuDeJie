//
//  XMGWordViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/20.
//  Copyright © 2016年 蒋进. All rights reserved.
//


import UIKit
import SVProgressHUD
import MJExtension
import MJRefresh
class XMGWordViewController: UITableViewController {
    

    /** 当前页码 */
    var page: Int = 0
    /** 当加载下一页数据时需要这个参数 */
    var maxtime: String?
    /** 上一次的请求参数 */
    var params: NSDictionary?
    /** 帖子数据 */
    lazy var topics = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
       
    }
    
    //MARK:  添加刷新控件
    ///  添加刷新控件
    func setupRefresh(){
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewTopics"))
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreTopics"))
        
        // 自动改变透明度
        self.tableView.mj_header.automaticallyChangeAlpha = true
        // 让用户表格进入下拉刷新状态
        self.tableView.mj_header.beginRefreshing()

    }
    
    /// 加载新的帖子数据
    func loadNewTopics(){

        // 结束上啦
        self.tableView.mj_footer.endRefreshing()
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "data";
        params["type"] = "29";
        //.存储请求参数.判断2次请求参数是否相同.不同就直接返回
        self.params = params
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            if (self.params != params) {return}
            (responseObject as! NSDictionary).writeToFile("/Users/jiangjin/Desktop/duanzi💗.plist", atomically: true)
            
            // 存储maxtime
            self.maxtime = (responseObject["info"] as! NSDictionary)["maxtime"] as? String

            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            self.topics = XMGTopic.mj_objectArrayWithKeyValuesArray(responseObject["list"])

            // 刷新表格
            self.tableView.reloadData()
            
            // 结束刷新
            self.tableView.mj_header.endRefreshing()
            
            // 清空页码
            self.page = 0;

            }) { (error) -> () in
                
                // 不是最后一次请求
                if (self.params != params) {return}
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                // 让底部控件结束刷新
                self.tableView.mj_header.endRefreshing()
        }
    }
    
    // 先下拉刷新, 再上拉刷新第5页数据
    
    // 下拉刷新成功回来: 只有一页数据, page == 0
    // 上啦刷新成功回来: 最前面那页 + 第5页数据
    
    /// 加载更多的帖子数据
    func loadMoreTopics(){
        
        // 结束下拉
        self.tableView.mj_header.endRefreshing()
        self.page++;

        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "data";
        params["type"] = "29";
        params["page"] = (self.page);
        params["maxtime"] = self.maxtime;
        //.存储请求参数.判断2次请求参数是否相同.不同就直接返回
        self.params = params
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 单个的cell就直接不加载数据
            // 如果是多个cell就先转成模型然后返回--不刷新数据
            if (self.params != params) {return}
            
            // 存储maxtime
            self.maxtime = (responseObject["info"] as! NSDictionary)["maxtime"] as? String
            
            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            let newTopics:NSArray = XMGTopic.mj_objectArrayWithKeyValuesArray(responseObject["list"])
            self.topics.addObjectsFromArray(newTopics as [AnyObject])
            // 刷新表格
            self.tableView.reloadData()
            
            // 结束刷新
            self.tableView.mj_footer.endRefreshing()
            
            // 清空页码
            self.page = 0;
            }) { (error) -> () in
                // 不是最后一次请求
                if (self.params != params) {return}
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                // 让底部控件结束刷新
                self.tableView.mj_footer.endRefreshing()
                // 恢复页码
                self.page--;
        }
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topics.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID:String = "contact"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID as String)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }

        
        let topic = self.topics[indexPath.row] as! XMGTopic
        cell!.textLabel!.text = topic.name
        cell!.detailTextLabel!.text = topic.text
        cell!.imageView!.sd_setImageWithURL(NSURL(string: topic.profile_image!), placeholderImage: UIImage(named: "defaultUserIcon"))
        
        
        return cell!
    }
    
}