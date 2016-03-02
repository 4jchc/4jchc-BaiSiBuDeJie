//
//  XMGRecommendCategory.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/16.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGRecommendCategory: NSObject {
    
    /** 总数 */
    var count: Int = 0
    /** id */
    var id: String = ""
    /** 名字 */
    var name: String = ""
    
    /** 这个类别对应的用户数据 */
    lazy var users:NSMutableArray? = NSMutableArray()
    
    
    /** 总数 */
    var total: NSNumber = 0
    /** 当前页码 */
    var currentPage: Int = 0
    
}
