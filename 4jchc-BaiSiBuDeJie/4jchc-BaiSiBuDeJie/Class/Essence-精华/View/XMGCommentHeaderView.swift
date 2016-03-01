//
//  XMGCommentHeaderView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/1.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGCommentHeaderView: UITableViewHeaderFooterView {
    
    /** 文字数据 */
    var title: String?{
        
        didSet{
            
            self.label.text = title;
            
        }
        
    }
    /// 加载XIB
    static func headerViewWithTableView(tableView:UITableView)->XMGCommentHeaderView {
        
        let ID:String = "header"
        var header:XMGCommentHeaderView? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ID) as? XMGCommentHeaderView
        
        if header == nil {// 缓存池中没有, 自己创建
            
            header = XMGCommentHeaderView(reuseIdentifier: ID)
        }
        return header!
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = XMGGlobalBg;
        // 创建label
        let label:UILabel = UILabel()
        label.width = 200;
        label.x = XMGTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizing.FlexibleHeight;
        label.textColor = UIColor.RGB(67, 67, 67)
        self.contentView.addSubview(label)
        self.label = label;

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 文字标签 */
    var label:UILabel = UILabel()
    
}
