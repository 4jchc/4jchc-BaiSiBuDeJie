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
    
    
    let XMGCategoryId:String = "category"
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
        categoryTableView.registerNib(UINib(nibName: "XMGRecommendCategoryCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: XMGCategoryId)
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
        
        
    }
    func loadMoreUsers(){
        

        let category = self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as! XMGRecommendCategory
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
            //[self checkFooterState];
            printLog("category.total=\(category.total)category.users?.count\(category.users?.count) ")
            if (category.users?.count) == (category.total){
                
                self.userTableView.mj_footer.endRefreshingWithNoMoreData()
                
            }else{
                self.userTableView.mj_footer.endRefreshing()
            }
            
            
            
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
    }
    
}

extension XMGRecommendViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.categoryTableView) { // 左边的类别表格
            return self.categorieS?.count ?? 0
            
        } else { // 右边的用户表格
            let c = self.categorieS?[(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!] as? XMGRecommendCategory
            // 每次刷新右边数据时, 都控制footer显示或者隐藏
            self.userTableView.tableFooterView?.hidden = (c?.users!.count == 0)
            return c?.users!.count ?? 0
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView == self.categoryTableView) { // 左边的类别表格
            
            let cell = tableView.dequeueReusableCellWithIdentifier(XMGCategoryId) as! XMGRecommendCategoryCell
            
            cell.category = self.categorieS![indexPath.row] as? XMGRecommendCategory
            return cell
        } else { // 右边的用户表格
            
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
            
            // 1.定义URL路径
            let path = "api/api_open.php"
            // 2.封装参数
            let params = NSMutableDictionary()
            params["a"] = "list";
            params["c"] = "subscribe";
            params["category_id"] = (c.id);
            NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
                printLog("params1\(params)")
                // 服务器返回的JSON数据- 字典数组 -> 模型数组
                let users:NSArray = XMGRecommendUser.mj_objectArrayWithKeyValuesArray(responseObject["list"])
                // 刷新表格
                // 设置当前页码为1
                c.currentPage = 1
                // 添加到当前类别对应的用户数组中
                c.users!.addObjectsFromArray(users as [AnyObject])
                // 保存总数
                c.total = responseObject["total"] as! Int
                self.userTableView.reloadData()
              
                if c.users?.count == c.total{
                    
                    self.userTableView.mj_footer.endRefreshingWithNoMoreData()
                }else{
                    
                    self.userTableView.mj_footer.endRefreshing()
                }
                printLog("responseObject2\(responseObject)")
                printLog("\(responseObject)")
                }) { (error) -> () in
                    // 显示失败信息
                    SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
            }
        }
    }
    
}
