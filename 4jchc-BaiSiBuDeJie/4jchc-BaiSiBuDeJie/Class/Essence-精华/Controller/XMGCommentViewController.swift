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
import AFNetworking

class XMGCommentViewController: UIViewController {
    
    let XMGCommentId:String = "comment"
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
    /** 保存帖子的top_cmt */
    var saved_top_cmt:XMGComment?

    /** 保存当前的页码 */
    var page: Int = 0
    
    /** 管理者 */
    var manager: NetworkTools! {
        get {
            return NetworkTools.shareNetworkTools()
        }

    }
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
        
        // 清空top_cmt
        if (self.topic.top_cmt != nil) {
            self.saved_top_cmt = self.topic.top_cmt!;
            self.topic.top_cmt = nil;
            self.topic.setValue(0, forKey: "cellHeighT")
        }
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
        
        
        let cell:XMGTopicCell = XMGTopicCell.viewFromXIB() 
        cell.topic = self.topic
        cell.size = CGSizeMake(XMGScreenW, self.topic.cellHeight!);
        header.addSubview(cell)
        
        header.height = self.topic.cellHeight!
        printLog("header.height=\(header.height)\n \(header.frame)")
        self.tableView.tableHeaderView = header;
    }
    
    //MARK:  添加刷新控件
    ///  添加刷新控件
    func setupRefresh(){
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewComments"))
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreComments"))
        self.tableView.mj_footer.hidden = true
        
    }
    func loadMoreComments(){
        
        // 结束之前的所有请求
        manager.tasks.forEach { $0.cancel() }

        // 页码
        let page = self.page + 1;
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "dataList";
        params["c"] = "comment";
        params["data_id"] = self.topic.ID;
        params["page"] = (page);
        let cmt = self.latestComments.lastObject as! XMGComment
        params["lastcid"] = cmt.ID;
        
        //.存储请求参数.判断2次请求参数是否相同.不同就直接返回
        self.params = params
        weak var weakSelf = self
        manager.sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 单个的cell就直接不加载数据
            // 如果是多个cell就先转成模型然后返回--不刷新数据
            // 最新评论
            // 没有数据
            if responseObject.isKindOfClass(NSDictionary.self){
                
                weakSelf?.tableView.mj_footer.hidden = true
                return
            }

            
            let newComments:NSArray = XMGComment.mj_objectArrayWithKeyValuesArray(responseObject["data"])
            self.latestComments.addObjectsFromArray(newComments as [AnyObject])
            // 页码
            self.page = page;
            if let weakSelf = weakSelf {
                
                if (weakSelf.params != params) {return}
                
                
                // 控制footer的状态
                if (responseObject["total"])!!.isKindOfClass(NSNumber.self){
                    
                    
                    let total:NSNumber? = responseObject["total"] as? NSNumber
                    
                    if (weakSelf.latestComments.count >= total!.integerValue) { // 全部加载完毕
                        weakSelf.tableView.mj_footer.hidden = true
                    }
                }else if (responseObject["total"])!!.isKindOfClass(NSString.self){
                    
                    let total:String? = responseObject["total"] as? String
                    
                    if (weakSelf.latestComments.count >= total!.toInt()) { // 全部加载完毕
                        weakSelf.tableView.mj_footer.hidden = true
                    }
                }
                
                // 刷新表格
                weakSelf.tableView.reloadData()
                
            }
        
            }) { (error) -> () in
                
                if let weakSelf = weakSelf {
                    
                    // 不是最后一次请求
                    if (weakSelf.params != params) {return}
                    // 显示失败信息
                    SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                    // 结束刷新
                    weakSelf.tableView.mj_footer.endRefreshing()
                }
        }
    }
    
    
    func loadNewComments(){
        // 结束之前的所有请求
        manager.tasks.forEach { $0.cancel() }
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
        weak var weakSelf = self
        manager.sendGET(path, params: params, successCallback: { (responseObject) -> () in
            // 单个的cell就直接不加载数据
            // 如果是多个cell就先转成模型然后返回--不刷新数据
            
            if let weakSelf = weakSelf {
                
                // 没有数据
                if responseObject.isKindOfClass(NSDictionary.self){
                    
                    weakSelf.tableView.mj_footer.hidden = true
                    return
                }
                
                if (weakSelf.params != params) {return}
                // 页码
                weakSelf.page = 1;
                // 最热评论
                //(responseObject as? NSDictionary).writeToFile("/Users/jiangjin/Desktop/duanzi💗.plist", atomically: true)
                
                weakSelf.hotComments = XMGComment.mj_objectArrayWithKeyValuesArray(responseObject["hot"])
                
                // 最新评论
                weakSelf.latestComments = XMGComment.mj_objectArrayWithKeyValuesArray(responseObject["data"])
                
                // 刷新表格
                weakSelf.tableView.reloadData()
                
                // 结束刷新
                weakSelf.tableView.mj_header.endRefreshing()
                
                printLog("打印了=\(responseObject["total"]!?.integerValue)")
                // 控制footer的状态
                if (responseObject["total"])!!.isKindOfClass(NSNumber.self){
                    
                    
                    let total:NSNumber? = responseObject["total"] as? NSNumber
                    
                    if (weakSelf.latestComments.count >= total!.integerValue) { // 全部加载完毕
                        weakSelf.tableView.mj_footer.hidden = true
                    }
                }else if (responseObject["total"])!!.isKindOfClass(NSString.self){
                    
                    let total:String? = responseObject["total"] as? String
                    
                    if (weakSelf.latestComments.count >= total!.toInt()) { // 全部加载完毕
                        weakSelf.tableView.mj_footer.hidden = true
                    }
                }
                

            
            }
            }) { (error) -> () in
                
                if let weakSelf = weakSelf {
                
                    // 不是最后一次请求
                    //if (weakSelf.params != params) {return}
                    // 显示失败信息
                    SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
                    // 让底部控件结束刷新
                    weakSelf.tableView.mj_header.endRefreshing()
                }

        }
    }
    
    
    func setupBasic(){
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.title = "评论";
        // 设置导航栏左的按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("comment_nav_item_share_icon", target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        self.tableView.backgroundColor = XMGGlobalBg;
        // cell的高度设置estimated估计的 RowHeight估计的
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        // 注册cell
        self.tableView.registerNib(UINib(nibName: "XMGCommentCell", bundle: nil), forCellReuseIdentifier: XMGCommentId)
        // 去掉分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        // 内边距
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XMGTopicCellMargin, 0);


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
        // 恢复帖子的top_cmt
//        if (self.saved_top_cmt.count != 0) {
//            
//            self.topic.top_cmt = self.saved_top_cmt;
//            self.topic.setValue(0, forKey: "cellHeighT")
//
//        }
        self.manager.tasks.forEach { $0.cancel() }

        //TODO:AFN 取消所有任务会报错
        //self.manager.invalidateSessionCancelingTasks(true)
    }
    // 将自己的文字复制到粘贴板
    func ding(menu: AnyObject?) {
        // 当前的索引
        let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
        printLog("\(commentInIndexPath(indexPath).content)-\(__FUNCTION__)")
        
    }
    
    // 将自己的文字复制到粘贴板
    func replay(sender: AnyObject?) {
        // 当前的索引
        let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
        printLog("\(commentInIndexPath(indexPath).content)-\(__FUNCTION__)")
    }
    
    func report(sender: AnyObject?) {
        // 当前的索引
        let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
        printLog("\(commentInIndexPath(indexPath).content)-\(__FUNCTION__)")
    }
    
}
extension XMGCommentViewController:UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)
        UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 当前的索引
        let hotCount:Int = self.hotComments.count;
        let latestCount:Int = self.latestComments.count;
        // 隐藏尾部控件
        tableView.mj_footer?.hidden = (latestCount == 0);
        if (hotCount != 0) {
            
            return 2; // 有"最热评论" + "最新评论" 2组
        }
        if (latestCount != 0) {
            
            return 1; // 有"最新评论" 1 组
        }
        return 0;

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let hotCount:Int = self.hotComments.count;
        let latestCount:Int = self.latestComments.count;
        if (section == 0) {
            return hotCount != 0 ? hotCount : latestCount
        }
        
        // 非第0组
        return latestCount
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
    
        
        let cell:XMGCommentCell = tableView.dequeueReusableCellWithIdentifier(XMGCommentId)! as! XMGCommentCell
        
        cell.comment = commentInIndexPath(indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 1.label要成为第一响应者(作用是:告诉UIMenuController支持哪些操作, 这些操作如何处理)
        // 被点击的cell

        
        // 2.显示MenuController
        let menu:UIMenuController = UIMenuController.sharedMenuController()
        // 添加MenuItem
        printLog("menu.menuVisible=\(menu.menuVisible)")
        if menu.menuVisible == true{
            
            menu.setMenuVisible(false, animated: true)
        }else{

            
            let cell:XMGCommentCell = tableView.cellForRowAtIndexPath(indexPath) as! XMGCommentCell
            // 出现一个第一响应者
            cell.becomeFirstResponder()
            
            let ding = UIMenuItem(title: "复制", action: Selector("ding:"))
            let replay = UIMenuItem(title: "剪切", action: Selector("replay:"))
            let report = UIMenuItem(title: "粘贴", action: Selector("report:"))
            
            menu.menuItems = [ding, replay, report]
            // targetRect: MenuController需要指向的矩形框
            // targetView: targetRect会以targetView的左上角为坐标原点
            let rect:CGRect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
            menu.setTargetRect(rect, inView: view)
            
            menu.setMenuVisible(true, animated: true)
             menu.update()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
}




extension XMGCommentViewController:TableViewCellDelegate{
    
    func tableCellSelected(tableCell: UITableViewCell) {
        let longprss : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("display:"))
        tableCell.addGestureRecognizer(longprss)
    }
    
    func display(gesture: UILongPressGestureRecognizer)
    {
        
        gesture.view?.becomeFirstResponder()
        
        print("Is first responder")
        let menu = UIMenuController.sharedMenuController()
        let deleteItem = UIMenuItem(title: "Delete", action: Selector("deleteLine:"))
        let editItems = UIMenuItem(title: "Edit", action: Selector("editRow:"))
        menu.menuItems = [deleteItem ,editItems]
        
        menu.setTargetRect(CGRect(x: 30, y: 8, width: 100, height: 50), inView: gesture.view!)
        menu.setMenuVisible(true, animated: true)
        
    }
}





