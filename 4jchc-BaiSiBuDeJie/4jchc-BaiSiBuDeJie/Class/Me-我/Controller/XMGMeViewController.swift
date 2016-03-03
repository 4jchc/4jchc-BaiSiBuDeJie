//
//  XMGMeViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGMeViewController: UITableViewController {
    
    let XMGMeId:String = "me"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupNav()

    }
    
    func setupTableView(){
 
        // 注册cell
        self.tableView.registerClass(XMGMeCell.self, forCellReuseIdentifier: XMGMeId)

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
        // 调整header和footer
        self.tableView.sectionHeaderHeight = 0;
        self.tableView.sectionFooterHeight = XMGTopicCellMargin;
        
//        //底部空间
//        let footer                         = UIView();
//        footer.backgroundColor = UIColor.redColor()
//        footer.frame                       = CGRectMake(0, 0, 0, 600);
//        self.tableView.tableFooterView     = footer;
        //                // 调整insetXMGTopicCellMargin
        self.tableView.contentInset = UIEdgeInsetsMake(XMGTopicCellMargin-35, 0, 0, 0);
        
        
        let footer:XMGMeFooterView = XMGMeFooterView()
        footer.frame = CGRectMake(0, 0, XMGScreenW, XMGMeFooterView.foothight)
        // 设置footerView
        //footer.frame = CGRectMake(0, 0, XMGScreenW, f)
        self.tableView.tableFooterView = footer
        
        
        //self.automaticallyAdjustsScrollViewInsets = false



    }
    
    func setupNav(){
        
        // 设置导航栏标题
        self.navigationItem.title = "我的";
        let settingItem:UIBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("mine-setting-icon", target: self, action: "settingClick")
        let moonItem:UIBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("mine-moon-icon", target: self, action: "moonClick")
        
        // 设置导航栏右边的按钮
        self.navigationItem.rightBarButtonItems = [settingItem, moonItem];

    }
    
    
    
    func settingClick()
    {
        printLog("")
    }
    
    func moonClick()
    {
        printLog("")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(XMGMeId) as! XMGMeCell
        if (indexPath.section == 0) {
            
            cell.imageView!.image = UIImage(named: "mine_icon_nearby")
            cell.textLabel!.text = "登录/注册";
        } else if (indexPath.section == 1) {
            cell.textLabel!.text = "离线下载";
        }
        return cell;
        
        

    }
    
    
    
    
    
    
    
}
