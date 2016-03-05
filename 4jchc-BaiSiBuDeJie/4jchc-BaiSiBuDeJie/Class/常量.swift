//
//  常量.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


let XMGGlobalBg:UIColor = UIColor.RGB(223, 223, 223)
let XMGTagBg:UIColor = UIColor.RGB(74, 139, 209)

/** 精华-顶部标题的高度 */
let XMGTitilesViewH:CGFloat = 35;
/** 精华-顶部标题的Y */
let XMGTitilesViewY:CGFloat = 64;

/** 精华-cell-间距 */
let XMGTopicCellMargin:CGFloat = 10;
/** 精华-cell-文字内容的Y值 */
let XMGTopicCellTextY:CGFloat = 55;
/** 精华-cell-底部工具条的高度 */
let XMGTopicCellBottomBarH:CGFloat = 44;

/** 精华-cell-图片帖子的最大高度 */
let XMGTopicCellPictureMaxH:CGFloat = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
let XMGTopicCellPictureBreakH:CGFloat = 250;

let XMGScreenW = UIScreen.mainScreen().bounds.size.width
let XMGScreenH = UIScreen.mainScreen().bounds.size.height

let XMGAnimationDelay:CGFloat = 0.1;
let XMGSpringFactor:CGFloat = 10


/** XMGUser模型-性别属性值 */
let XMGUserSexMale:String = "m";
let XMGUserSexFemale:String = "f";


/** 精华-cell-最热评论标题的高度 */
let XMGTopicCellTopCmtTitleH:CGFloat = 20

/** tabBar被选中的通知名字 */
let XMGTabBarDidSelectNotification = "XMGTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key */
let XMGSelectedControllerIndexKey = "XMGSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器 key */
let XMGSelectedControllerKey = "XMGSelectedControllerKey";


/** 标签-间距 */
let XMGTagMargin:CGFloat = 5;
/** 标签-高度 */
let XMGTagH:CGFloat = 25;

let XMGTagFont:UIFont = UIFont.systemFontOfSize(14)


let XMGNoteCenter = NSNotificationCenter.defaultCenter()
var IS_IPAD: Bool {
get {
    if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
        return true
    }
    else {
        return false
    }
}
}

var IS_IPHONE: Bool {
get {
    if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        return true
    }
    else {
        return false
    }
}
}


extension NSLayoutConstraint {
    
    //重写description.有错误会打印identifier
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
}
}





//MARK: - 单词
/*

Recommend推荐 ViewController
Essence基本-精华
Friend Trends-关注动态

//tableView出现的时候，清除选中状态
如果是tableViewController
self.clearsSelectionOnViewWillAppear = YES;
如果是viewController，在viewWillAppear方法里添加
[self.tableView deselectRowAtIndexPath:[self.contactsTableView indexPathForSelectedRow] animated:YES];
Multiplier乘法器

corner边角 Radius使...成圆角
self.layer.cornerRadius = 5
masks遮罩 To Bounds界线
self.layer.masksToBounds = true
1.user Defined定义的 Runtime运行时间 Attributes属性组

NS Comparison比较 Result.Ordered有秩序的 Descending递减

clip剪贴subviews

*/