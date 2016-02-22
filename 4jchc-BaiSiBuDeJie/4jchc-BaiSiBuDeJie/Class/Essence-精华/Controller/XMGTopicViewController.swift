//
//  XMGTopicViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/22.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJExtension
import MJRefresh


enum XMGTopicType:Int {
    case All = 1
    case Picture = 10
    case Word = 29
    case Voice = 31
    case Video = 41
}

class XMGTopicViewController: UITableViewController {
    

    /** 帖子类型(交给子类去实现) */

    var type: XMGTopicType?
        

        

    
    let XMGTopicCellId:String = "topic"
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
        
        /// 初始化表格
        setupTableView()
        /// 添加刷新控件
        setupRefresh()
        
    }
    /// 初始化表格
    func setupTableView() {
        
        // 设置内边距
        let bottom:CGFloat = self.tabBarController!.tabBar.height;
        let top:CGFloat = XMGTitilesViewY + XMGTitilesViewH;
        self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // 注册cell
        self.tableView.registerNib(UINib(nibName: "XMGTopicCell", bundle: nil), forCellReuseIdentifier: XMGTopicCellId)
        
        
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
        params["type"] = self.type?.rawValue
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
        
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "data";
        params["type"] = self.type?.rawValue
        // 当前的索引
        let page:Int = self.page + 1
        params["page"] = page
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
            // 设置页码
            self.page = page
            }) { (error) -> () in
                // 不是最后一次请求
                if (self.params != params) {return}
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                // 让底部控件结束刷新
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    // MARK: - 数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.tableView.mj_footer.hidden = (self.topics.count == 0);
        return self.topics.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(XMGTopicCellId) as! XMGTopicCell
        cell.topic = self.topics[indexPath.row] as? XMGTopic
        
        return cell
    }
    // MARK: - 代理方法
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // 取出帖子模型
        let topic = self.topics[indexPath.row] as! XMGTopic;

        // 文字的最大尺寸
        let maxSize:CGSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 4 * XMGTopicCellMargin, CGFloat(MAXFLOAT))

        let textH:CGFloat = (topic.text! as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14)], context: nil).size.height

        // cell的高度
        let cellH:CGFloat = XMGTopicCellTextY + textH + XMGTopicCellBottomBarH + 2 * XMGTopicCellMargin;
        
        return cellH;
    }
    
}
