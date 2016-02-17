//
//  XMGRecommendUserCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SDWebImage
class XMGRecommendUserCell: UITableViewCell {

    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var fansCountLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /** 用户模型 */
    var user:XMGRecommendUser?{
        
        didSet{
            
          
            self.screenNameLabel.text = user!.screen_name;
            
            var subNumber:String = ""
            if (user!.fans_count < 10000) {
                
                subNumber = "\(user!.fans_count)人关注"
                
            }else{ // 大于等于10000
                
                subNumber = String(format: "%.1f万人关注", CGFloat(user!.fans_count) / 10000.0)
                
            }
            self.fansCountLabel.text = subNumber
            self.headerImageView.sd_setImageWithURL(NSURL(string: (user!.header)), placeholderImage: UIImage(named: "defaultUserIcon"))
            
        }
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
