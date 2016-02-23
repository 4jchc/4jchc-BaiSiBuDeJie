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

    /*
    //MARK: 6. 精华-顶部标签内容
    1.遍历数组添加5个按钮到view上
    2.带alpha的颜色
    titlesView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
    */


    /*
    //MARK: 7. 精华-顶部标签内容的点击
    1.让按钮内部的label根据文字内容来计算尺寸
    button.titleLabel!.sizeToFit()
    2.记录当前选中的按钮状态
    */


    /*
    //MARK: 8. 精华-底部的scrollView
    1.添加标签控制器代码
    */


    /*
    //MARK: 9. 添加scrollView动画💗
    1.当点击按钮的时候才设置红色指示器的位置
    2.用到顶部标签内容数组下标--所以指示器的view最后添加
    3.一页设置5个子控制器.标签是一个view加5个button通过数组的下标访问
    scrollView代理的使用.结束滚动的时候判断是哪一个控制器
    4.通过contentview的尺寸 / scrollView.width位置
    Int(scrollView.contentOffset.x / scrollView.width)
    5.设置滚动范围 self.contentView!.width
    var offset:CGPoint = self.contentView!.contentOffset;
    offset.x = CGFloat(button.tag)  * self.contentView!.width
    6. 不要自动调整ScrollView Insets
    self.automaticallyAdjustsScrollViewInsets = false
    */

    /*
    //MARK: 10. 子控制器显示细节
    1.结束滚动动画完毕--通过索引--加载UITableViewController的view
    一定要设置view的x.y.
    vc.view.x = scrollView.contentOffset.x;
    设置控制器view的y值为0(默认是20)包含状态栏20
    vc.view.y = 0;
    contentOffset.x就是偏移的X轴距离
    */


    /*
    //MARK: 11. 加载文字帖子数据
    */
//MARK: - 第四天


    /*
    //MARK: 1. 💗加载文字帖子数据完善
    1.MJ刷新控件在初始化的时候要隐藏Foot
    2.每次刷新新数据页码💗在成功加载到数据以后清0
    3.每次加载更多数据的时候要在模型里添加刚刚的模型数据
    如果加载失败.要在失败闭包里清除刚刚加载的1--page
    4.重复的网络请求加载-只取最后一次的网络请求💗单个的cell就直接不加载数据
    如果是多个cell就先转成模型然后返回--不刷新数据
    5.上拉刷新的时候--结束下拉刷新--下拉的时候--结束上拉
    */

    /*
    //MARK: 2. 文字帖子细节处理💗
    1.加载更多数据-不需要一进来就++.可以设置一个临时💗的page page = self.page + 1
    成功加载完毕的时候在赋值前一次的page就可以了..这样加载失败的时候就不用--了
    2.scrollViewDidEndScrollingAnimation
    取出子控制器💗设置 x y轴 以后有可能是不同的UIViewController而非都是UITableViewController
    let vc:UIViewController = self.childViewControllers[index]
    设置内边距让他们自己设置
     设置滚动条的内边距scroll Indicator Insets
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    */

    /*
    //MARK: 3. 数据转模型加载
    1.cell取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    2.cell的内嵌--重写💗frame
    */

    /*
    //MARK: 4. 时间处理
    1.在模型didset方法中设置时间
    2.封装时间显示
    */

    /*
    //MARK: 5. 加V认证处理
    */

    /*
    //MARK: 6. 代码重构💗
    1.可以是继承父类.重写参数形式
    */


    /*
    //MARK: 7. 代码重构💗
    2.因为都是UITableViewController--只是请求参数不同,所以定义枚举带参数来确定是哪个控制器
    */

//MARK: - 第五天

    /*
    //MARK: 1. 简单计算cell的高度
    */

    /*
    //MARK: 2. 高度--使用懒加载方式
    1.cell的高度放在模型里设置
    2.💗之前说--cell的时间没有更新是因为设置了set-didSet方法..应该改为Get方法
    不会更新时间是因为KVC赋值的时候才访问这个
    应该写成Get方法这样才会访问到这里获取时间更新
    3.💗Get方法cell滚动的时候就会调用也就是--取值的时候调用.set的方法只有在字典转模型设置值的时候调用
    Didset方法是赋值的时候调用
    Set方法和懒加载是取值的时候调用cell的高度不是模型里的是需要我们自己设值
    4.Get方法会频繁调用所以使用懒加载代替---时间除外.可以更新别人是什么时候发的帖子
    模型的不可以直接使用Get方法.所以从新定义一个变量来进行Get方法调用模型里的数据
    */


    /*
    //MARK: 3. 图片帖子中间的内容
    1.如果设置的图片尺寸是对的但是-显示错误--就取消自伸缩图片auto resizing调整 Mask屏蔽
    self.autoresizingMask = UIViewAutoresizing.None;
    */


    /*
    //MARK: 4. 判断jif图片Extension扩展名
    1.(topic!.large_image! as NSString).pathExtension图片后缀
    2.图片裁剪--SB-clip剪贴subviews
    */

    /*
    //MARK: 5. 图片帖子细节
    1.基本数据类型一定要设置初始值
    2.MJ字典转模型.swift属性不可以设置成枚举型的.
    3.枚举获取类型加rawValue
    */


    /*
    //MARK: 6. 占位图片-进度条显示
    1.添加DACircularProgress第三方框架显示进度条
    */












