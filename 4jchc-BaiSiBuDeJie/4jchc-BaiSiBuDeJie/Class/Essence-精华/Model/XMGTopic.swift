//
//  XMGTopic.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/21.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopic: NSObject {
    
    /** 名称 */
    var name: String?
    /** 头像 */
    var profile_image: String?
    /** 文字内容 */
    var text: String?
    
    
    /** 发帖时间 */
    var create_time: String?
    var create_Time: String? {
        
        get{
            return self.create_time?.descriptionDate()
        }
    }


    /** 顶的数量 */
    var ding: Int = 0
    /** 踩的数量 */
    var cai: Int = 0
    /** 转发的数量 */
    var repost: Int = 0
    /** 评论的数量 */
    var comment: Int = 0
    /** 是否为新浪加V用户 */
    var sina_v: Bool = false

    /****** 额外的辅助属性 ******/
    
    /** cell的高度 */

    
    lazy var cellHeight:CGFloat = {
        
        // 文字的最大尺寸
        let maxSize:CGSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 4 * XMGTopicCellMargin, CGFloat(MAXFLOAT))
        
        let textH:CGFloat = (self.text! as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14)], context: nil).size.height
        
        // cell的高度
        let ani = XMGTopicCellTextY + textH + XMGTopicCellBottomBarH + 2 * XMGTopicCellMargin;
        
        return ani
    }()
}
