//
//  XMGAddTagToolbar.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGAddTagToolbar: UIView {
    /** 顶部控件 */
    @IBOutlet weak var topView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // 添加一个加号按钮
        let button:UIButton = UIButton()
        button.addTarget(self, action: "addButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: "tag_add_icon"), forState: .Normal)
        button.size = button.currentImage!.size;
        button.x = XMGTopicCellMargin;
        self.topView.addSubview(button)
        
    }
    func addButtonClick(){
        /*
        let vc = XMGAddTagViewController()
        // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
        let root:UIViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        let nav = root.presentedViewController as? UINavigationController
        nav?.pushViewController(vc, animated: true)
        */


    }

}
