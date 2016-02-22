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
    /** 顶部的所有标签 */
    var titlesView:UIView?
    /** 底部的所有内容 */
    var contentView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        setupNav()
        // 初始化子控制器
        setupChildVces()
        // 设置顶部的标签栏
        setupTitlesView()
        // 底部的scrollView
        setupContentView()
        
    }
    
    //MARK: 设置顶部的标签栏
    func setupTitlesView(){
        
        // 标签栏整体
        let titlesView:UIView = UIView()
        titlesView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        titlesView.width = self.view.width;
        titlesView.height = XMGTitilesViewH;
        titlesView.y = XMGTitilesViewY;
        self.view.addSubview(titlesView)
        self.titlesView = titlesView;
        // 底部的红色指示器
        let indicatorView:UIView = UIView()
        indicatorView.backgroundColor = UIColor.redColor()
        indicatorView.height = 2;
        indicatorView.tag = -1
        indicatorView.y = titlesView.height - indicatorView.height;
        
        self.indicatorView = indicatorView;
        
        // 内部的子标签
        let width:CGFloat = titlesView.width / CGFloat(self.childViewControllers.count)
        let height:CGFloat = titlesView.height
        
        for var i:Int = 0; i < self.childViewControllers.count; i++ {
            let button:UIButton = UIButton()
            button.tag = i
            button.height = height;
            button.width = width;
            button.x = CGFloat(i)  * width;
            let vc:UIViewController = self.childViewControllers[i];
            button.setTitle(vc.title, forState: UIControlState.Normal)
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
        titlesView.addSubview(indicatorView)
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
        // 设置滚动范围
        var offset:CGPoint = self.contentView!.contentOffset;
        offset.x = CGFloat(button.tag)  * self.contentView!.width
        
        self.contentView?.setContentOffset(offset, animated: true)
        
        
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
    
    //MARK: - 底部的scrollView
    func setupContentView(){
        
        // 不要自动调整ScrollView Insets
        self.automaticallyAdjustsScrollViewInsets = false
        let contentView = UIScrollView()
        contentView.frame = self.view.bounds;
        contentView.delegate = self;
        contentView.pagingEnabled = true
        self.view.insertSubview(contentView, atIndex: 0)
        
        contentView.contentSize = CGSizeMake(contentView.width * CGFloat(self.childViewControllers.count), 0);
        self.contentView = contentView;
        
        // 添加第一个控制器的view
        self.scrollViewDidEndScrollingAnimation(contentView)
        
        
        
    }
    
    //MARK: 初始化子控制器
    func setupChildVces(){

        let all = XMGTopicViewController()
        all.title = "全部";
        all.type = XMGTopicType.All;
        self.addChildViewController(all)
        
        let video = XMGTopicViewController()
        video.title = "视频";
        video.type = XMGTopicType.Video
        self.addChildViewController(video)
        
        let voice = XMGTopicViewController()
        voice.title = "声音";
        voice.type = XMGTopicType.Voice;
        self.addChildViewController(voice)
        
        let picture = XMGTopicViewController()
        picture.title = "图片";
        picture.type = XMGTopicType.Picture;
        self.addChildViewController(picture)
        
        let word = XMGTopicViewController()
        word.title = "段子";
        word.type = XMGTopicType.Word;
        self.addChildViewController(word)
    }
    
    func tagClick(){
        
        let tags = XMGRecommendTagsViewController()
        self.navigationController?.pushViewController(tags, animated: true)
        
    }
    
    
}


extension XMGEssenceViewController:UIScrollViewDelegate {
    
    //MARK: 结束滚动动画完毕调用Scrolling Animation
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        // 当前的索引
        let index:Int = Int(scrollView.contentOffset.x / scrollView.width)
        /*
        // 取出子控制器
        let vc:UITableViewController = self.childViewControllers[index] as! UITableViewController
        
        // 一定要设置view的x.y
        vc.view.x = scrollView.contentOffset.x;
        vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
        vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
        
        // 设置内边距
        let bottom:CGFloat = self.tabBarController!.tabBar.height;
        let top:CGFloat = CGRectGetMaxY(self.titlesView!.frame);
        vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
        */
        
        // 取出子控制器💗设置 xy轴 以后有可能是不同的UIViewController而非都是UITableViewController
        let vc:UIViewController = self.childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x;
        vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
        vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
        // 设置内边距让他们自己设置
        
        scrollView.addSubview(vc.view)
        
        
    }
    //MARK: 减速完毕调用End  Decelerating减速
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        // 点击按钮
        let index:Int = Int(scrollView.contentOffset.x / scrollView.width)
        self.titleClick(self.titlesView?.subviews[index] as! UIButton)
        
    }
    
}





