//
//  XMGCommentCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/1.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGCommentCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var sexView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!

    //@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /** 评论 */
    var comment:XMGComment?{
        
        didSet{
            
            self.profileImageView.sd_setImageWithURL(NSURL(string: comment!.user!.profile_image!), placeholderImage: UIImage(named: "defaultUserIcon"))

            self.sexView.image = comment!.user!.sex?.isEqualToString(XMGUserSexMale) == true ? UIImage(named: "Profile_manIcon") : UIImage(named: "Profile_womanIcon")
            
            self.contentLabel.text = comment!.content;
            self.usernameLabel.text = comment!.user!.username;
            self.likeCountLabel.text = String(format: "%zd",comment!.like_count)
            
//            if (comment.voiceuri.length) {
//                self.voiceButton.hidden = false
//                
//                //[self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
//            } else {
//                self.voiceButton.hidden = true
//            }
            
        }
        
    }
}
