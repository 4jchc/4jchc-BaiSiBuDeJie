//
//  BaiSiBuDeJie开发笔记.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


//MARK: - 第一天
    /*
    //MARK: 1. 自定义UITabBarController子控制器
    UITabBarItem的外观appearance
     通过appearance统一设置所有UITabBarItem的文字属性
     后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置

    */

    /*
    //MARK: 2. 自定义TabBar修改位置
    1.KVC换掉系统的TabBar
    setValue(newTabBar, forKey: "tabBar")
    2.init(frame: CGRect)里设置子控件的frame是没有用的要在layoutSubviews里设置
    3.UITabBarButton为私有 let Class:AnyClass = NSClassFromString("UITabBarButton")!
    */

    /*
    //MARK: 3. 设置导航栏
    1.添加Frame的扩展
    2.封装UIBarButtonItem
    3.添加自定义打印log
    */

    /*
    //MARK: 4. 调整项目文件结构
    */


    /*
    //MARK: 5. 自定义导航控制器拦截push设置返回键super的push要放在后面
    */

    /*
    //MARK: 6. 当第一次使用这个类的时候会调用一次initialize的使用

    */

    /*
    //MARK: 7. 添加第三方库
    */

    /*
    //MARK: 8. 发送网络请求
    */






//MARK: - 第二天

    /*
    //MARK: 1. 添加MJExtension设置左边的数据--获取右边list列表
    1.获取左边list列表
    2.当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
    在自定义cell的setSelected里设置选中的高亮状态
    3.mj字典转模型
    XMGRecommendCategory.mj_objectArrayWithKeyValuesArray(responseObject["list"])
    4.自定义Insets嵌入为64--导航栏
    设置automatically自动地 Adjusts调整 ScrollView Insets嵌入
    self.automaticallyAdjustsScrollViewInsets = false
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    */


    /*
    //MARK: 2. 解决重复发送请求
    1.在主模型里添加一个可变数组,每点击一个cell就会保存相应的数组.不同的cell.对应不同的数组
    2.右边模型的数组是左边模型的指定cell来的,所以右边模型访问左边cell
    3.左边模型对应的rou是通过--模型(self.categoryTableView.indexPathsForSelectedRows?.last?.row)!
    每一个左边的数据都是一个模型所以.定一个可变的数组保存对应的右边的数据
    */

    /*
    //MARK: 3. 加载第2页数据
    1.无法加载第2页数据.page为2没纸
    */

    /*
    //MARK: 4. 加载数据的判断---只有1业而已记录当前的页码
    1.记录总数和数组的个数相比-记录当前页码 判断返回的数据页数和总数,如果不相同就加载
    */

    /*
    //MARK: 5. 上拉刷新完成 💗上拉下拉都要进行--数据有没有的判断.
    1.下拉刷新的时候就要判断是否还有数据没有Footview就显示没有数据可以加载了
    2.常用的判断封装成代码段
     时刻监测footer的状态(加载完毕--显示已经加载完毕.还有数据就显示-下拉刷新)
    3.封装左边选中的cell方法.一开始访问为空.所以方法为可选checkCategories
     当点击的时候就一定有值 所以直接在调用的方法后面加!
    */

    /*
    //MARK: 6. 每次加载完成都要检测Footview的状态
    1.下拉刷新要删除旧数据重新加载.因为网络加载的是-页码形式无法像微博那样有最大值
    */


    /*
    //MARK: 7. 控制器销毁处理
    1.每次点击cell都要结束刷新
    2.第一次保存临时请求参数.2次判断是否相同.不同就直接返回
    3.---退出控制器就要--停止所有操作operation Queue
    NetworkTools.shareNetworkTools().operationQueue.cancelAllOperations()
    */


    /*
    //MARK: 8. 1.一开始网络加载数据就 设置 1.默认选中首行
    self.categoryTableView.selectRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
                   2 .让用户表格进入下拉刷新状态
    self.userTableView.mj_header.beginRefreshing()
    2.第一次保存临时请求参数.-----2次判断是否相同.----不同就直接返回❌
    3.数据已经加载了就存起来,不要刷新就行了
    */

    /*
    //MARK: 9. 精华左边-推荐标签
    1.纯代码写UITableViewController要写
    tableView.delegate = self tableView.dataSource = self
    2.完成数字为万的设置
    3.设置cell的位置2边进5.宽度减少2倍
    重写Frame不可以写成didset方法
    */



//MARK: - 第三天

    /*
    //MARK: 1. 快速登录界面搭建
    1.自定义XMGVerticalButton--实现按钮的图片在上--文字在下只要继承就行
    2.报错-fatalError("init(coder:) has not been implemented")
    去掉加上super.init
    */

    /*
    //MARK: 2. 登录界面搭建
    设置图片圆角 
     corner边角 Radius使...成圆角
    self.layer.cornerRadius = 5
     masks遮罩 To Bounds界线
    self.layer.masksToBounds = true
    1.在SB中设置按钮的user Defined定义的 Runtime运行时间 Attributes属性组
    */

    /*
    //MARK: 3. 设置自定义文本UITextField的占位符颜色和光标颜色
    1.KVC路径是keypath.
    */


    /*
    //MARK: 4. 登录界面完善
    */

    /*
    //MARK: 5. 推送引导页
    判断版本.
    1.获取当前软件的版本号 --> info.plist
    let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    2.存储当前最新的版本号  iOS7以后就不用调用同步方法了
    NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
    3.比较当前版本号和以前版本号 2.0  1.0 NS Comparison比较 Result.Ordered有秩序的 Descending递减
    if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending{
    */


