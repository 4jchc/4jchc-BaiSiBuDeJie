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
import MJExtension
import MJRefresh
class XMGRecommendViewController: UIViewController {
    

    
    
    lazy var XMGSelectedCategory:XMGRecommendCategory? = {
        var New = self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as? XMGRecommendCategory
        return New
    }()
  
    /** 左边的类别数据 */
    var categorieS:NSArray?

    
    /** 右边的用户数据 */
     // var users:NSArray?
     
     /** 左边的类别表格 */
    @IBOutlet weak var categoryTableView: UITableView!
    /** 右边的用户表格 */
    @IBOutlet weak var userTableView: UITableView!
    
    
    let XMGcategoryId:String = "category"
    let XMGUserId:String = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 控件的初始化
        setupTableView()
        //  添加刷新控件
        setupRefresh()
        // 显示指示器
        SVProgressHUD.showInfoWithStatus("正在加载...", maskType: SVProgressHUDMaskType.Black)
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "category";
        params["c"] = "subscribe";
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 隐藏指示器
            SVProgressHUD.dismiss()
            // 服务器返回的JSON数据
            self.categorieS = XMGRecommendCategory.mj_objectArrayWithKeyValuesArray(responseObject["list"])
            // 刷新表格
            
            self.categoryTableView.reloadData()
            
            // 默认选中首行
            self.categoryTableView.selectRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
            
            printLog("responseObject1\(responseObject)")
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
        
        
    }

    //MARK:   控件的初始化
    ///   控件的初始化
    func setupTableView(){
        
        // 注册cell
        categoryTableView.registerNib(UINib(nibName: "XMGRecommendCategoryCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: XMGcategoryId)
        userTableView.registerNib(UINib(nibName: "XMGRecommendUserCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: XMGUserId)
        // 设置automatically自动地 Adjusts调整 ScrollView Insets嵌入
        self.automaticallyAdjustsScrollViewInsets = false
        self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.userTableView.contentInset = self.categoryTableView.contentInset;
        self.userTableView.rowHeight = 70;
        
        // 设置标题
        self.title = "推荐关注";
        
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
    }
    
    //MARK: - 添加刷新控件
    ///  添加刷新控件
    func setupRefresh(){
        
        self.userTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewUsers"))
        
        self.userTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreUsers"))
        

    }
    
    func loadNewUsers(){
        let category = self.checkCategories()!

        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "subscribe";
        params["category_id"] = (category.id);
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            printLog("params1\(params)")
            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            let users:NSArray = XMGRecommendUser.mj_objectArrayWithKeyValuesArray(responseObject["list"])
            // 刷新表格
            // 设置当前页码为1
            category.currentPage = 1
            // 清除所有旧数据
            category.users!.removeAllObjects()
            // 添加到当前类别对应的用户数组中
            category.users!.addObjectsFromArray(users as [AnyObject])
            // 保存总数
            category.total = responseObject["total"] as! Int
            self.userTableView.reloadData()
            
            self.userTableView.mj_header.endRefreshing()
            

            // 让底部控件结束刷新
            self.checkFooterState()
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
    }


    func loadMoreUsers(){
        
        let category = self.checkCategories()!

        // 发送请求给服务器, 加载右侧的数据
        //self.params = params;
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "subscribe";
        params["category_id"] = category.id
        params["page"] = (++category.currentPage);
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            
            printLog("params2\(params)")
            // 服务器返回的JSON数据- 字典数组 -> 模型数组
            let users:NSArray = XMGRecommendUser.mj_objectArrayWithKeyValuesArray(responseObject["list"])
            // 刷新表格
            
            // 添加到当前类别对应的用户数组中
            category.users!.addObjectsFromArray(users as [AnyObject])
            
            // 不是最后一次请求
           // if (self.params != params) {return}
            
            // 刷新右边的表格
            self.userTableView.reloadData()
            
            // 让底部控件结束刷新
            self.checkFooterState()
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
    }
    

     //MARK: - 时刻监测footer的状态(加载完毕--显示已经加载完毕.还有数据就显示-下拉刷新)
     ///  时刻监测footer的状态(加载完毕--显示已经加载完毕.还有数据就显示-下拉刷新)
    func checkFooterState() {
        // 拿出的是那一段
        let category = checkCategories()
        // 让底部控件结束刷新
        if (category?.users?.count) == (category?.total){// 全部数据已经加载完毕
            
            self.userTableView.mj_footer.endRefreshingWithNoMoreData()
            
        }else{
        // 还没有加载完毕
            self.userTableView.mj_footer.endRefreshing()
        }
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        self.userTableView.tableFooterView?.hidden = (category?.users!.count == 0)
    }
    //MARK: - 监测右边的数据--获取左边的是哪一行所持有的数据
    ///  监测右边的数据--获取左边的是哪一行所持有的数据
    func checkCategories()->XMGRecommendCategory?{
        
        return self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as? XMGRecommendCategory
    }
    /*
    //MARK: - 监测是哪个cell
    ///  监测是哪个cell
    func checkCell(tableView: UITableView,Identifier:String)->UITableViewCell?{
        
        if Identifier == XMGcategoryId{
            
            return tableView.dequeueReusableCellWithIdentifier(XMGcategoryId) as! XMGRecommendCategoryCell
            
        }else{
            return tableView.dequeueReusableCellWithIdentifier(XMGUserId) as! XMGRecommendUserCell
        }
    }
    */
    
    
}

extension XMGRecommendViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.categoryTableView) { // 左边的类别表格
            return self.categorieS?.count ?? 0
            
        } else { // 右边的用户表格

           /* 
            let category = self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as? XMGRecommendCategory
            if (category?.users?.count) == (category?.total){
                
                self.userTableView.mj_footer.endRefreshingWithNoMoreData()
                
            }else{
                self.userTableView.mj_footer.endRefreshing()
            }
            // 每次刷新右边数据时, 都控制footer显示或者隐藏
            self.userTableView.tableFooterView?.hidden = (category?.users!.count == 0)
            */
            checkFooterState()
            return self.checkCategories()?.users?.count ?? 0
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView == self.categoryTableView) { // 左边的类别表格
            
            let cell = tableView.dequeueReusableCellWithIdentifier(XMGcategoryId) as! XMGRecommendCategoryCell
            
            cell.category = self.categorieS![indexPath.row] as? XMGRecommendCategory
            return cell
        } else { // 右边的用户表格--来自左边的模型
            
            let cell = tableView.dequeueReusableCellWithIdentifier(XMGUserId) as! XMGRecommendUserCell
            let c = self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as? XMGRecommendCategory
            
            cell.user = c!.users![indexPath.row] as? XMGRecommendUser;
            return cell;
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let c:XMGRecommendCategory = self.categorieS![indexPath.row] as! XMGRecommendCategory
        printLog("\(c.users?.count)")
        if ((c.users?.count) != 0) {
            // 显示曾经的数据
            self.userTableView.reloadData()
            
        } else {
            
            self.userTableView.reloadData()
            self.userTableView.mj_header.beginRefreshing()

        }
    }
    
}
