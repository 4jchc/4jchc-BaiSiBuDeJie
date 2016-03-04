//
//  XMGTopicVideoView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopicVideoView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videolengthLabel: UILabel!
    @IBOutlet weak var playcountLabel: UILabel!
    
    
    

    
    override func awakeFromNib() {
        // 取消自动调整伸缩
        self.autoresizingMask = UIViewAutoresizing.None;
        // 给图片添加监听器
        self.imageView.userInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPicture")
        self.imageView.addGestureRecognizer(tap)
        
        
    }
    
    func showPicture(){
        
        let showPicture:XMGShowPictureViewController = XMGShowPictureViewController()
        showPicture.topic = self.topic;
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(showPicture, animated: true, completion: nil)
        
        
    }
    
    var topic:XMGTopic?{
        
        didSet{
            
            // 图片
            self.imageView.sd_setImageWithURL(NSURL(string: topic!.large_image!))
            
            // 播放次数
            self.playcountLabel.text = String(format: "%zd播放", topic!.playcount)
            
            // 时长
            // 当前的索引
            let minute:Int = (topic!.videotime / 60)
            // 当前的索引
            let second:Int = topic!.videotime % 60;
            
            self.videolengthLabel.text = String(format: "%02zd:%02zd", minute, second)
            
            
        }
        
    }

}
