//
//  XMGPublishView.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/25.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import pop
class XMGPublishView: UIView {
    
   static var window_:UIWindow!
    
    static func show(){
        
        // 创建窗口
        window_ = UIWindow()
        window_.frame = ScreenBounds
        window_.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        window_.hidden = false

        
        // 添加发布界面
        let publishView:XMGPublishView = XMGPublishView.publishView()
        publishView.frame = window_.bounds;
        window_.addSubview(publishView)

    }
    
    static func publishView()->XMGPublishView{

        return NSBundle.mainBundle().loadNibNamed("XMGPublishView", owner: nil, options: nil).first as! XMGPublishView
            

    }
    
    override func awakeFromNib() {
  
        
        // 让view不能被点击
        //XMGRootView.userInteractionEnabled = false
        
        // 不能被点击
        self.userInteractionEnabled = false

        
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
            // 设置内容
            button.tag = i;
            button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            button.setTitle(titles[i] as? String, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.setImage(UIImage(named: (images[i] as! String)), forState: .Normal)
            
            
            // 计算X\Y
            button.width = buttonW;
            button.height = buttonH;
            let row:Int = i / maxCols
            let col:Int = i % maxCols
            let buttonX:CGFloat = buttonStartX + CGFloat(col) * (xMargin + buttonW);
            let buttonEndY:CGFloat =  buttonStartY + CGFloat(row) * buttonH;
            let buttonBeginY:CGFloat = buttonEndY - XMGScreenH;
            
            // 按钮动画
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            anim.springBounciness = XMGSpringFactor;
            anim.springSpeed = XMGSpringFactor;
            anim.fromValue =  NSValue(CGRect: CGRectMake(buttonX, buttonBeginY, buttonW, buttonH))
            anim.toValue = NSValue(CGRect: CGRectMake(buttonX, buttonEndY, buttonW, buttonH))
            
            anim.beginTime = CACurrentMediaTime() + Double(XMGAnimationDelay * CGFloat(i))
            button.pop_addAnimation(anim, forKey: nil)
            
        }
        
        // 添加标语
        let sloganView:UIImageView = UIImageView(image: UIImage(named: "app_slogan"))
        sloganView.y = XMGScreenH * 0.2;
        sloganView.centerX = XMGScreenW * 0.5;
        self.addSubview(sloganView)
        
        // 标语动画
        let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        let centerX:CGFloat = XMGScreenW * 0.5;
        let centerEndY:CGFloat =  XMGScreenH * 0.2;
        let centerBeginY:CGFloat = centerEndY - XMGScreenH
        
        
        anim.springBounciness = XMGSpringFactor;
        anim.springSpeed = XMGSpringFactor;
        anim.fromValue =  NSValue(CGPoint: CGPointMake(centerX, centerBeginY))
        anim.toValue = NSValue(CGPoint: CGPointMake(centerX, centerEndY))
        anim.beginTime = CACurrentMediaTime() + Double(XMGAnimationDelay * CGFloat(images.count))

        anim.completionBlock = { [unowned self] (anim, finished) in
            
            print("动画结束")
            // 标语动画执行完毕, 恢复点击事件
            //XMGRootView.userInteractionEnabled = true
            self.userInteractionEnabled = true
        }
        sloganView.pop_addAnimation(anim, forKey: nil)

    }
    func buttonClick(button:UIButton){
        
        cancelWithCompletionBlock { () -> () in
            if (button.tag == 0) {
                
                print("发视频");
            } else if (button.tag == 1) {
                print("发图片");
            }
        }

    }

    
    @IBAction func cancel(sender: AnyObject) {
        
        cancelWithCompletionBlock(nil)
    }
    
    
    
    
    

    //MARK:  先执行退出动画, 动画完毕后执行completionBlock
    ///  先执行退出动画, 动画完毕后执行completionBlock
    func cancelWithCompletionBlock(completionBlock:(()->())?){
        // 不能被点击
        //XMGRootView.userInteractionEnabled = false
        // 让控制器的view不能被点击
        self.userInteractionEnabled = false
        let beginIndex:Int = 1//2
        for var i:Int = beginIndex; i < self.subviews.count; i++ {
            
            let subview:UIView = self.subviews[i];

            // 基本动画
            let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            let centerY:CGFloat = subview.centerY + XMGScreenH;

            // 动画的执行节奏(一开始很慢, 后面很快)
            //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            anim.toValue = NSValue(CGPoint: CGPointMake(subview.centerX, centerY))
            anim.beginTime = CACurrentMediaTime() + Double(XMGAnimationDelay * CGFloat(i - beginIndex))
            subview.pop_addAnimation(anim, forKey: nil)

            // 监听最后一个动画
            if (i == self.subviews.count - 1) {
                anim.completionBlock = { (anim, finished) in
                    
                    print("动画结束")
                    // 标语动画执行完毕, 恢复点击事件
                    //XMGRootView.userInteractionEnabled = true
                    // 销毁窗口
                    
                    XMGPublishView.window_ = nil;
                    //self.removeFromSuperview()
                    // 执行传进来的completionBlock参数
                    if (completionBlock != nil) {
                        completionBlock!();
                    }

                }
            }
        }


    }

    
    /**
     pop和Core Animation的区别
     1.Core Animation的动画只能添加到layer上
     2.pop的动画能添加到任何对象
     3.pop的底层并非基于Core Animation, 是基于CADisplayLink
     4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
     5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        cancelWithCompletionBlock(nil)
        /*
        let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim.springBounciness = 20;
        anim.springSpeed = 20;
        anim.fromValue =  NSValue(CGPoint: CGPointMake(100, 100))
        anim.toValue = NSValue(CGPoint: CGPointMake(200, 200))
        //[self.sloganView pop_addAnimation:anim forKey:nil];
        */
        
        
        /*
        let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        anim.beginTime = CACurrentMediaTime() + 1.0;
        anim.springBounciness = 20;
        anim.springSpeed = 20;
        
        anim.fromValue = (self.sloganView.layer.position.y);
        anim.toValue = (300);
        anim.completionBlock = { [unowned self] (anim, finished) in
        
        print("动画结束")
        
        }
        [self.sloganView.layer pop_addAnimation:anim forKey:nil];
        
        */
    }
    
}
