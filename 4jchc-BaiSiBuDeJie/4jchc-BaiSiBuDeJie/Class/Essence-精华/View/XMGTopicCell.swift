//
//  XMGTopicCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/21.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTopicCell: UITableViewCell {
    
    /** 头像 */
    @IBOutlet weak var profileImageView: UIImageView!
    /** 昵称 */
    @IBOutlet weak var nameLabel: UILabel!
    /** 时间 */
    @IBOutlet weak var createTimeLabel: UILabel!
    /** 顶 */
    @IBOutlet weak var dingButton: UIButton!
    /** 踩 */
    @IBOutlet weak var caiButton: UIButton!
    /** 分享 */
    @IBOutlet weak var shareButton: UIButton!
    /** 评论 */
    @IBOutlet weak var commentButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var topic:XMGTopic?{
        
        didSet{
            
            // 设置其他控件
            self.profileImageView.sd_setImageWithURL(NSURL(string: topic!.profile_image!), placeholderImage: UIImage(named: "defaultUserIcon"))
            self.nameLabel.text = topic!.name;
            self.createTimeLabel.text = topic!.create_time;
            
            // 设置按钮文字
            setupButtonTitle(dingButton, count: topic!.ding, placeholder: "顶")
            setupButtonTitle(caiButton, count: topic!.cai, placeholder: "踩")
            
            setupButtonTitle(shareButton, count: topic!.repost, placeholder: "分享")
            setupButtonTitle(commentButton, count: topic!.comment, placeholder: "评论")

        }
        
    }
    //MARK: 按钮的文字分为3种情况
    func setupButtonTitle(button:UIButton,count:Int,var placeholder:String){

        if (count > 10000) {
            placeholder = String(format: "%.1f万", (Double(count) / 10000.0))
            
            
        } else if (count > 0) {
            placeholder = String(format: "%zd", count)
            
        }
        button.setTitle(placeholder, forState: UIControlState.Normal)
        
    }

    
    //MARK: 重写frame来设置cell的内嵌
    override var frame:CGRect{
        set{
            
            var frame = newValue
            let margin:CGFloat = 10
            frame.origin.x = margin;
            frame.size.width -= 2 * margin;
            frame.size.height -= margin;
            frame.origin.y += margin;
            super.frame=frame
        }
        get{
            return super.frame
        }
    }
}
