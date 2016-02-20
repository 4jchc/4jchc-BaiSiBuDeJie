//
//  XMGRecommendCategoryCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGRecommendCategoryCell: UITableViewCell {

    /** 选中时显示的指示器控件 */
    @IBOutlet weak var selectedIndicator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // 当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
        self.backgroundColor = UIColor.RGB(244, 244, 244)
        self.selectedIndicator.backgroundColor = UIColor.RGB(219, 21, 26);

    }

    var category:XMGRecommendCategory?{
        
        didSet{
            
            self.textLabel!.text = category!.name;
            
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 重新调整内部textLabel的frame
        self.textLabel?.font = UIFont.systemFontOfSize(13)
        self.textLabel!.y = 2;
        self.textLabel!.height = self.contentView.height - 2 * self.textLabel!.y;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectedIndicator.hidden = !selected;
        self.textLabel!.textColor = selected ? self.selectedIndicator.backgroundColor : UIColor.RGB(78, 78, 78);
    }
    
}
