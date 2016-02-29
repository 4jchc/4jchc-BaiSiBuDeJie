//
//  XMGCommentViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGCommentViewController: UIViewController {
    
    
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
        // Do any additional setup after loading the view.
    }
    func setupBasic(){
        
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
    
    
    
    deinit
    {
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
}
extension XMGCommentViewController:UITableViewDelegate{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    }
    
    
}