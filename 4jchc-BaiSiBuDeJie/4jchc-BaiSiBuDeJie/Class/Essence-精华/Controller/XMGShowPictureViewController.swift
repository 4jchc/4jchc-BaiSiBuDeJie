//
//  XMGShowPictureViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/2/25.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SVProgressHUD
class XMGShowPictureViewController: UIViewController {

    /** 帖子 */
    var topic:XMGTopic!
    @IBOutlet weak var progressView: XMGProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView:UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加图片
        let imageView:UIImageView = UIImageView()
        imageView.userInteractionEnabled = true
        // 给图片添加监听器
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "back")
        imageView.addGestureRecognizer(tap)
        self.scrollView.addSubview(imageView)
        self.imageView = imageView
        
        
        // 图片尺寸
        let pictureW = XMGScreenW
        let pictureH = pictureW * self.topic.height / self.topic.width;

        if (pictureH > XMGScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
            imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
            self.scrollView.contentSize = CGSizeMake(0, pictureH);
        } else {
            imageView.size = CGSizeMake(pictureW, pictureH);
            imageView.centerY = XMGScreenH * 0.5;
        }
        // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
        self.progressView.setProgress(self.topic.pictureProgress, animated: true)
        
        weak var weakSelf = self

        // 设置图片带进度
        self.imageView!.sd_setImageWithURL(NSURL(string: self.topic.large_image!),placeholderImage: nil, options: .CacheMemoryOnly, progress: { (receivedSize, expectedSize) -> Void in
            if let weakSelf = weakSelf {
                
            weakSelf.progressView.hidden = false
            let progress:CGFloat =  CGFloat(receivedSize)/CGFloat(expectedSize)
            weakSelf.progressView.setProgress(progress, animated: false)
            weakSelf.progressView.progressLabel.text = String(format: "%.0f%%", progress * CGFloat(100))
            }
            }) { (image, error, cacheType, imageURL) -> Void in
                 if let weakSelf = weakSelf {
                    
                weakSelf.progressView.hidden = true
                }
        }
 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK:  保存图片到相册
    ///  保存图片到相册
    @IBAction func save() {
        if (self.imageView!.image == nil) {
            
            SVProgressHUD.showErrorWithStatus("图片并没下载完毕!", maskType: SVProgressHUDMaskType.Black)
     
            return;
        }
        let image = self.imageView!.image
        UIImageWriteToSavedPhotosAlbum(image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        // - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    }
    

    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject){//UnsafePointer<Void>
        if error != nil
        {
            SVProgressHUD.showErrorWithStatus("保存失败", maskType: SVProgressHUDMaskType.Black)
        }else
        {
            SVProgressHUD.showSuccessWithStatus("保存成功", maskType: SVProgressHUDMaskType.Black)
        }
    }

}
