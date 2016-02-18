//
//  XMGRecommendTagCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/17.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJExtension
import MJRefresh
class XMGRecommendTagCell: UITableViewCell {
    
    
    @IBOutlet weak var imageListImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var subNumberLabel: UILabel!
    
    
    var recommendTag:XMGRecommendTag?{
        
        didSet{
            
            
            self.themeNameLabel.text = recommendTag!.theme_name;
            var subNumber:String = ""
            printLog("recommendTag!.sub_number\(recommendTag!.sub_number)\(recommendTag!.sub_number < 10000)")
            if (recommendTag!.sub_number < 10000) {
                
                subNumber = "\(recommendTag!.sub_number)人订阅"
                
            } else { // 大于等于10000
                
                subNumber = String(format: "%.1f万人关注", CGFloat(recommendTag!.sub_number) / 10000.0)
                
            }
            self.subNumberLabel.text = subNumber;
            
            self.imageListImageView.sd_setImageWithURL(NSURL(string: (recommendTag!.image_list)!), placeholderImage: UIImage(named: "defaultUserIcon"))
            
        }
        
    }

        override var frame:CGRect{
            set{
                var frame = newValue
    
                frame.origin.x = 5.0
                frame.size.width -= 2 * frame.origin.x;
                frame.size.height -= 1;
                super.frame=frame
            }
            get{
                return super.frame
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
