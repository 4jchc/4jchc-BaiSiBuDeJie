//
//  XMGWebViewController.swift
//  4jchc-BaiSiBuDeJie
//
//  Created by 蒋进 on 16/3/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import NJKWebViewProgress
class XMGWebViewController: UIViewController {
    /** 链接 */
    var url: String?
    
    /** 进度代理对象 */
    var progress: NJKWebViewProgress?
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.progress = NJKWebViewProgress()
        self.webView.delegate = self.progress;
        
        weak var weakSelf = self
        
        self.progress!.progressBlock = {(progress) in
            if let weakSelf = weakSelf {
                
                weakSelf.progressView.progress = progress;
                
                weakSelf.progressView.hidden = (progress == 1.0);
            }

        
        }
        self.progress!.webViewProxyDelegate = self;
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: self.url!)!))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh(sender: AnyObject) {
        self.webView.reload()
    }
    @IBAction func goBack(sender: AnyObject) {
        self.webView.goBack()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        self.webView.goForward()
    }


}
extension XMGWebViewController :UIWebViewDelegate{
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.goBackItem.enabled = webView.canGoBack;
        self.goForwardItem.enabled = webView.canGoForward;
    }
    
}





