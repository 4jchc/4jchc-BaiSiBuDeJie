//
//  XMGCommentViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
class XMGCommentViewController: UIViewController {
    
    /** 帖子模型 */
    var topic:XMGTopic!
    /** 上一次的请求参数 */
    var params: NSDictionary?
    /** 工具条底部间距 */
    @IBOutlet weak var bottomSapce: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    /** 最热评论 */
    var hotComments:NSArray = []
    
    /** 最新评论 */
    var latestComments:NSMutableArray=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        setupHeader()
        setupRefresh()
        // Do any additional setup after loading the view.
    }
    func setupHeader(){
        
        // 创建header
        let header:UIView = UIView()
        
        //        // 清空top_cmt
        //        if (self.topic.top_cmt.count) {
        //            self.saved_top_cmt = self.topic.top_cmt;
        //            self.topic.top_cmt = nil;
        //            [self.topic setValue:@0 forKeyPath:"cellHeight"];
        //        }
        /*
        // 不要自动调整ScrollView Insets
        self.automaticallyAdjustsScrollViewInsets = true
        // 设置内边距
        let bottom:CGFloat = self.tabBarController!.tabBar.height;
        let top:CGFloat = XMGTitilesViewY + XMGTitilesViewH;
        self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        */
        
        
        let cell:XMGTopicCell = XMGTopicCell.cell()
        cell.topic = self.topic
        cell.size = CGSizeMake(XMGScreenW, self.topic.cellHeight);
        header.addSubview(cell)
        
        header.height = self.topic.cellHeight
        printLog("header.height=\(header.height)\n \(header.frame)")
        self.tableView.tableHeaderView = header;
    }
    
    //MARK:  添加刷新控件
    ///  添加刷新控件
    func setupRefresh(){
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewComments"))
        self.tableView.mj_header.beginRefreshing()
        
       // self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreUsers"))
        
        
    }
    
    func loadNewComments(){
        
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "dataList";
        params["c"] = "comment";
        params["data_id"] = self.topic.ID;
        params["hot"] = "1";
        
        //.存储请求参数.判断2次请求参数是否相同.不同就直接返回
        self.params = params
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 单个的cell就直接不加载数据
            // 如果是多个cell就先转成模型然后返回--不刷新数据
            if (self.params != params) {return}
            
            // 最热评论
            
            self.hotComments = XMGComment.mj_objectArrayWithKeyValuesArray(responseObject["hot"])
            
            // 最新评论
            self.latestComments = XMGComment.mj_objectArrayWithKeyValuesArray(responseObject["data"])
            
            // 刷新表格
            self.tableView.reloadData()
            
            // 结束刷新
            self.tableView.mj_header.endRefreshing()

            }) { (error) -> () in
                // 不是最后一次请求
                if (self.params != params) {return}
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                // 让底部控件结束刷新
                self.tableView.mj_header.endRefreshing()
        }
    }
    
    
    func setupBasic(){
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.title = "评论";
        // 设置导航栏左的按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("comment_nav_item_share_icon", target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        self.tableView.backgroundColor = XMGGlobalBg;
    }
    
    
    func keyboardWillChangeFrame(note: NSNotification){
        
        // 键盘显示\隐藏完毕的frame
        let frame:CGRect = note.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        // 修改底部约束
        self.bottomSapce.constant = XMGScreenH - frame.origin.y;
        // 动画时间
        let duration:Double = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        // 动画 及时刷新
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    /**
     * 返回第section组的所有评论数组
     */
    func commentsInSection(section:NSInteger)->NSArray{
        
        if (section == 0) {
            return self.hotComments.count != 0 ? self.hotComments : self.latestComments;
        }
        return self.latestComments;
        
    }
    
    func commentInIndexPath(indexPath:NSIndexPath)->XMGComment{
        
        return commentsInSection(indexPath.section)[indexPath.row]  as! XMGComment
        
    }
    
    
    deinit
    {
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
}
extension XMGCommentViewController:UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 当前的索引
        let hotCount:Int? = self.hotComments.count;
        let latestCount:Int? = self.latestComments.count;

        if (hotCount != nil) {
            
            return 2; // 有"最热评论" + "最新评论" 2组
        }
        if (latestCount != nil) {
            
            return 1; // 有"最新评论" 1 组
        }
        return 0;

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let hotCount:Int? = self.hotComments.count;
        let latestCount:Int? = self.latestComments.count;
        if (section == 0) {
            return (hotCount != nil ? hotCount : latestCount)!
        }
        
        // 非第0组
        return latestCount!
    }
    
    

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // 先从缓存池中找header
        let header:XMGCommentHeaderView = XMGCommentHeaderView.headerViewWithTableView(tableView)
        // 设置label的数据

        let hotCount:Int? = self.hotComments.count;
        if (section == 0) {
            header.title = hotCount != nil ? "最热评论" : "最新评论";
        } else {
            header.title = "最新评论";
        }
        return header
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let ID:String = "contact"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: ID)
        }
        let comment:XMGComment = commentInIndexPath(indexPath)
        cell!.textLabel!.text = comment.content
        return cell!
    }
}










