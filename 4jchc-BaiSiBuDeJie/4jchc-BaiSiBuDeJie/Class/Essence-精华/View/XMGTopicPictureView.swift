//
//  XMGTopicPictureView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/22.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopicPictureView: UIView {
    
    /** 图片 */
    @IBOutlet weak var imageView: UIImageView!
    
    /** gif标识 */
    @IBOutlet weak var gifView: UIImageView!
    
    /** 查看大图按钮 */
    @IBOutlet weak var seeBigButton: UIButton!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    /// 加载XIB
    static func pictureView()->XMGTopicPictureView {
        
        return NSBundle.mainBundle().loadNibNamed("XMGTopicPictureView", owner: nil, options: nil).first as! XMGTopicPictureView
        
    }
    
    
    override func awakeFromNib() {
        // 取消自动调整伸缩
        self.autoresizingMask = UIViewAutoresizing.None;
    }
    
    var topic:XMGTopic?{
        
        didSet{
            // 设置图片
            self.imageView.sd_setImageWithURL(NSURL(string: topic!.large_image!), placeholderImage: UIImage(named: ""))
            
        }
    }
    
}
