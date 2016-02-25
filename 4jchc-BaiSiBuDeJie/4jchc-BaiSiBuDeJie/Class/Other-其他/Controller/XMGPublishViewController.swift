//
//  XMGPublishViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/25.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGPublishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 添加标语
        let sloganView:UIImageView = UIImageView(image: UIImage(named: "app_slogan"))

        sloganView.y = XMGScreenH * 0.2;
        sloganView.centerX = XMGScreenW * 0.5;
        self.view.addSubview(sloganView)

        // 数据
        
        let images:NSArray = ["publish-video", "publish-picture", "publish-text", "publish-audio", "publish-review", "publish-offline"];
        let titles:NSArray = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"];
        
        // 中间的6个按钮
        let maxCols:Int = 3
        
        
        let buttonW:CGFloat  = 72;
        let buttonH:CGFloat  = buttonW + 30;
        let buttonStartY:CGFloat  = (XMGScreenH - 2 * buttonH) * 0.5;

        let buttonStartX:CGFloat = IS_IPHONE ? 20 : 100
        let xMargin:CGFloat =  (XMGScreenW - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat( (maxCols - 1))
        for var i:Int = 0; i < images.count; i++ {
            
            let button:XMGVerticalButton = XMGVerticalButton()
            button.setTitle(titles[i] as? String, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.setImage(UIImage(named: (images[i] as! String)), forState: .Normal)
       
            
            // 设置frame
            button.width = buttonW;
            button.height = buttonH;
            let row:Int = i / maxCols
            let col:Int = i % maxCols
            button.x = buttonStartX + CGFloat(col) * (xMargin + buttonW);
            button.y = buttonStartY + CGFloat(row) * buttonH;
            self.view.addSubview(button)


        }
    }


    
    @IBAction func cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
