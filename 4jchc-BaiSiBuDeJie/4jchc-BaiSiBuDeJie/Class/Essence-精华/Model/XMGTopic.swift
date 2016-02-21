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
    /** 发帖时间 */
    var create_time: String?
    /** 文字内容 */
    var text: String?
    
    
    /** 顶的数量 */
    var ding: Int = 0
    /** 踩的数量 */
    var cai: Int = 0
    /** 转发的数量 */
    var repost: Int = 0
    /** 评论的数量 */
    var comment: Int = 0
    
    

}
