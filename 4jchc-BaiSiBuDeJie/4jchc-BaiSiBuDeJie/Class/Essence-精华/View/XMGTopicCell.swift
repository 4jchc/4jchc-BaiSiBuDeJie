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
    /** 新浪加V */
    @IBOutlet weak var sinaVView: UIImageView!
    /** 帖子的文字内容 */
    @IBOutlet weak var text_label: UILabel!
    

    lazy var pictureView:XMGTopicPictureView = {
        let ani = XMGTopicPictureView.pictureView()
        self.contentView.addSubview(ani)
        return ani
    }()
    
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
            
            // 设置头像
            self.profileImageView.sd_setImageWithURL(NSURL(string: topic!.profile_image!), placeholderImage: UIImage(named: "defaultUserIcon"))
            // 设置名字
            self.nameLabel.text = topic!.name;
            // 新浪加V
            self.sinaVView.hidden = !topic!.sina_v
            self.createTimeLabel.text = topic!.create_Time;
            
            // 设置按钮文字
            setupButtonTitle(dingButton, count: topic!.ding, placeholder: "顶")
            setupButtonTitle(caiButton, count: topic!.cai, placeholder: "踩")
            setupButtonTitle(shareButton, count: topic!.repost, placeholder: "分享")
            setupButtonTitle(commentButton, count: topic!.comment, placeholder: "评论")
            
            // 设置帖子的文字内容
            self.text_label.text = topic!.text
            
            // 根据模型类型(帖子类型)添加对应的内容到cell的中间
            if (topic!.type == XMGTopicType.Picture) { // 图片帖子
                self.pictureView.topic = topic;
                self.pictureView.frame = topic!.pictureF;
            } else if (topic!.type == XMGTopicType.Voice) { // 声音帖子
                //        self.voiceView.topic = topic;
                //        self.voiceView.frame = topic.voiceF;
            }

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
            frame.origin.x = XMGTopicCellMargin;
            frame.size.width -= 2 * XMGTopicCellMargin;
            frame.size.height -= XMGTopicCellMargin;
            frame.origin.y += XMGTopicCellMargin;
            super.frame=frame
        }
        get{
            return super.frame
        }
    }
}
