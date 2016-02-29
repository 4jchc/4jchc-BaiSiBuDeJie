//
//  XMGTopicVoiceView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopicVoiceView: UIView {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var voicelengthLabel: UILabel!
    @IBOutlet weak var playcountLabel: UILabel!
    
    
    
    /// 加载XIB
    static func voiceView()->XMGTopicVoiceView {

        return NSBundle.mainBundle().loadNibNamed("XMGTopicVoiceView", owner: nil, options: nil).first as! XMGTopicVoiceView
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 取消自动调整伸缩
        self.autoresizingMask = UIViewAutoresizing.None;
    }
    
    var topic:XMGTopic?{
        
        didSet{
            
            // 图片
            self.imageView.sd_setImageWithURL(NSURL(string: topic!.large_image!))
            
            // 播放次数
            self.playcountLabel.text = String(format: "%zd播放", topic!.playcount)
            
            // 时长
            // 当前的索引
            let minute:Int = (topic!.voicetime / 60)
            // 当前的索引
            let second:Int = topic!.voicetime % 60;
            
            self.voicelengthLabel.text = String(format: "%02zd:%02zd", minute, second)
            
            
        }
        
    }
    
    
    
}
