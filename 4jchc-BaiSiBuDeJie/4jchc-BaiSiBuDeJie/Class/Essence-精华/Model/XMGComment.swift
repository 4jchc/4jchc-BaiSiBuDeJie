//
//  XMGComment.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGComment: NSObject {
    
    /** 音频文件的时长 */
    var voicetime: Int = 0
    /** 音频文件的路径 */
    var voiceuri: NSString?

    /** 评论的文字内容 */
    var content: String?

    /** 被点赞的数量 */
    var like_count: Int = 0

    /** 用户 */
    var user:XMGUser?

}
