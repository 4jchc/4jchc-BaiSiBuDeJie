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
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
            titlesView.addSubview(button)
            
        }
        // 底部的红色指示器
        let indicatorView:UIView = UIView()
        indicatorView.backgroundColor = UIColor.redColor()
        indicatorView.height = 2;
        indicatorView.y = titlesView.height - indicatorView.height;
        titlesView.addSubview(indicatorView)
        self.indicatorView = indicatorView;
    }
    
    func titleClick(button:UIButton){
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
