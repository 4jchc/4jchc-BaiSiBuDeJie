//
//  XMGMeCell.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGMeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
        let imageView:UIImageView = UIImageView(image: UIImage(named: "mainCellBackground"))

        self.backgroundView = imageView;
        
        self.textLabel!.textColor = UIColor.darkGrayColor()
        self.textLabel!.font = UIFont.systemFontOfSize(16)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if (self.imageView!.image == nil) {return}
        
        self.imageView!.width = 30;
        self.imageView!.height = self.imageView!.width;
        self.imageView!.centerY = self.contentView.height * 0.5;
        
        self.textLabel!.x = CGRectGetMaxX(self.imageView!.frame) + XMGTopicCellMargin;
    }
    

    
    //- (void)setFrame:(CGRect)frame
    //{
    ////    XMGLog(@"%@", NSStringFromCGRect(frame));
    //    frame.origin.y -= (35 - XMGTopicCellMargin);
    //    [super setFrame:frame];
    //}
    //MARK: 重写frame来设置cell的内嵌
    /*
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
    }    */

    
    
    
}
