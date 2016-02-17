//
//  XMGRecommendTagsViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/17.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import MJExtension
import MJRefresh
import SVProgressHUD
class XMGRecommendTagsViewController: UITableViewController {

    /** 标签数据 */
    var tags:NSArray?
    
    let XMGTagsId:String = "tag"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadTags()
    }
    func loadTags(){
        
        // 显示指示器
        SVProgressHUD.showInfoWithStatus("正在加载...", maskType: SVProgressHUDMaskType.Black)
        // 1.定义URL路径
        let path = "api/api_open.php"
        // 2.封装参数
        let params = NSMutableDictionary()
        params["a"] = "tag_recommend";
        params["action"] = "sub";
        params["c"] = "topic";
        
        NetworkTools.shareNetworkTools().sendGET(path, params: params, successCallback: { (responseObject) -> () in

            // 隐藏指示器
            SVProgressHUD.dismiss()
            // 服务器返回的JSON数据
            self.tags = XMGRecommendTag.mj_objectArrayWithKeyValuesArray(responseObject)
            // 刷新表格
            self.tableView.reloadData()
            printLog("\(responseObject)")
            }) { (error) -> () in
                // 显示失败信息
                SVProgressHUD.showErrorWithStatus("加载推荐信息失败!")
        }
    }
    
    func setupTableView(){
   
        // 注册cell
        self.tableView.registerNib(UINib(nibName: "XMGRecommendTagCell", bundle: nil), forCellReuseIdentifier: XMGTagsId)
        tableView.delegate = self
        tableView.dataSource = self
        // 设置标题
        self.title = "推荐标签";
        self.tableView.rowHeight = 70;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tags?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(XMGTagsId, forIndexPath: indexPath) as! XMGRecommendTagCell
        
        cell.recommendTag = self.tags![indexPath.row] as? XMGRecommendTag;
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
