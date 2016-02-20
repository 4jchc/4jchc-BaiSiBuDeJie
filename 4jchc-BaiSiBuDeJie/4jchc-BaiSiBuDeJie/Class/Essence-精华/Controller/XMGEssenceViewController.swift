//
//  XMGEssenceViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGEssenceViewController: UIViewController {
    
    /** 标签栏底部的红色指示器 */
    var indicatorView:UIView?
    /** 当前选中的按钮 */
    var selectedButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        setupNav()
        // 设置顶部的标签栏
        setupTitlesView()
        
    }
    
    //MARK: 设置顶部的标签栏
    func setupTitlesView(){
        
        // 标签栏整体
        let titlesView:UIView = UIView()
        titlesView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        titlesView.width = self.view.width;
        titlesView.height = 35;
        titlesView.y = 64;
        self.view.addSubview(titlesView)
  
        // 底部的红色指示器
        let indicatorView:UIView = UIView()
        indicatorView.backgroundColor = UIColor.redColor()
        indicatorView.height = 2;
        indicatorView.y = titlesView.height - indicatorView.height;
        titlesView.addSubview(indicatorView)
        self.indicatorView = indicatorView;
        
        // 内部的子标签
        let titles:NSArray = ["全部全部", "视频", "声音", "图片", "段子"]
        let width:CGFloat = titlesView.width / CGFloat(titles.count)
        let height:CGFloat = titlesView.height
        
        for var i:Int = 0; i < titles.count; i++ {
            let button:UIButton = UIButton()
            button.height = height;
            button.width = width;
            button.x = CGFloat(i)  * width;
            button.setTitle(titles[i] as? String, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
            titlesView.addSubview(button)
            // 默认点击了第一个按钮
            if (i == 0) {
                button.enabled = false
                self.selectedButton = button;
                
                // 让按钮内部的label根据文字内容来计算尺寸
                button.titleLabel!.sizeToFit()
                
                self.indicatorView!.width = button.titleLabel!.width;
                self.indicatorView!.centerX = button.centerX;
            }
            
        }

    }

    func titleClick(button:UIButton){
        
        // 修改按钮状态
        self.selectedButton!.enabled = true
        button.enabled = false
        self.selectedButton = button;
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.indicatorView!.width = button.titleLabel!.width;
            self.indicatorView!.centerX = button.centerX;
        }

    }
    
    
    //MARK: 设置导航栏
    func setupNav() {
        // 设置导航栏标题
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        
        // 设置导航栏左的按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithBarButtonItem("MainTagSubIcon", target: self, action: "tagClick")
        // 设置背景色
        self.view.backgroundColor = XMGGlobalBg;
    }
    
    func tagClick(){
        
        let tags = XMGRecommendTagsViewController()
        self.navigationController?.pushViewController(tags, animated: true)
        
    }
    
}
