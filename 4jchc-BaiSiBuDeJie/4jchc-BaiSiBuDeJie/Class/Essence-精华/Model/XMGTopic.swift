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
    
    
    /** 图片的宽度 */
    var width:CGFloat = 0
    /** 图片的高度 */
    var height:CGFloat = 0
    /** 小图片的URL */
    var small_image: String?
    /** 中图片的URL */
    var middle_image: String?
    /** 大图片的URL */
    var large_image: String?
    /** 帖子的类型 */
    //var type:XMGTopicType?
    var type:Int = 0
        
    /** 音频时长 */
    var voicetime: Int = 0
    /** 视频时长 */
    var videotime: Int = 0
    /** 播放次数 */
    var playcount: Int = 0
    /** 最热评论(期望这个数组中存放的是XMGComment模型) */
    //var top_cmt:NSArray?
    
   var top_cmt:NSArray?{
        
        didSet{
            
            printLog("\(top_cmt)")
            
        }
        
    }
    

    /****** 额外的辅助属性 ******/
     /** 图片控件的frame */
    var pictureF:CGRect = CGRect()
    /** 图片是否太大 */
    var isBigPicture: Bool = false
    
    /** 图片的下载进度 */
    var pictureProgress:CGFloat = CGFloat()
    
    /** 声音控件的frame */
    var voiceF:CGRect = CGRect()

    /** 视频控件的frame */
    var videoF:CGRect = CGRect()
    
    /** cell的高度 */// 同时计算图片的尺寸
    lazy var cellHeight:CGFloat = {
        
        // 文字的最大尺寸
        let maxSize:CGSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 4 * XMGTopicCellMargin, CGFloat(MAXFLOAT))
        
        let textH:CGFloat = (self.text! as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14)], context: nil).size.height
        
        // 根据段子的类型来计算cell的高度
        // 文字部分的高度
        var CellHeight = XMGTopicCellTextY + textH + XMGTopicCellMargin;
        
        if (self.type == XMGTopicType.Picture.rawValue) { // 图片帖子
            
            // 图片显示出来的宽度
            let pictureW:CGFloat = maxSize.width;
            // 显示显示出来的高度
            var pictureH:CGFloat = pictureW * self.height / self.width;
            
            if (pictureH >= XMGTopicCellPictureMaxH) { // 图片高度过长
                pictureH = XMGTopicCellPictureBreakH;
                self.isBigPicture = true; // 大图
            }
            // 计算图片控件的frame
            let pictureX:CGFloat = XMGTopicCellMargin
            let pictureY:CGFloat = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            self.pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            CellHeight += pictureH + XMGTopicCellMargin;
        } else if (self.type == XMGTopicType.Voice.rawValue) { // 声音帖子
            
            // 图片显示出来的宽度
            let voiceW:CGFloat = maxSize.width;
            // 显示显示出来的高度
            var voiceH:CGFloat = voiceW * self.height / self.width;

            // 计算图片控件的frame
            let voiceX:CGFloat = XMGTopicCellMargin
            let voiceY:CGFloat = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            self.voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
              CellHeight += voiceH + XMGTopicCellMargin;
 
        }else if (self.type == XMGTopicType.Video.rawValue) { // 视频帖子
            
            // 图片显示出来的宽度
            let videoW:CGFloat = maxSize.width;
            // 显示显示出来的高度
            var videoH:CGFloat = videoW * self.height / self.width;
            
            // 计算图片控件的frame
            let videoX:CGFloat = XMGTopicCellMargin
            let videoY:CGFloat = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            self.videoF = CGRectMake(videoX, videoY, videoW, videoH);
            CellHeight += videoH + XMGTopicCellMargin;

        }
        
        // 如果有最热评论
        let cmt = self.top_cmt?.firstObject as? XMGComment
        
        if ((cmt) != nil) {
            
            let content:NSString = NSString(format: "%@ : %@", cmt!.user!.username!, cmt!.content!)
            // 文字的最大尺寸

            let contentH:CGFloat = (content).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(13)], context: nil).size.height
            
            CellHeight += XMGTopicCellTopCmtTitleH + contentH + XMGTopicCellMargin;
        }
        
        // 底部工具条的高度
        CellHeight += XMGTopicCellBottomBarH + XMGTopicCellMargin;

        return CellHeight
    }()
    
    
    // 告诉mj数组里对应的是什么模型
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["top_cmt" : XMGComment.classForCoder()]
    }

    // 替换属性名
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return [
            "small_image" : "image0",
            "large_image" : "image1",
            "middle_image" : "image2"]
    }

}
