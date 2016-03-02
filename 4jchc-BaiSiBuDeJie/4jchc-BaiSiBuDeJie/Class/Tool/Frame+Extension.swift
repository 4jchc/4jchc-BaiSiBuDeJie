

import Foundation
import UIKit
extension UIView{
    var x:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.origin.x=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    var y:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.origin.y=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    var centerX:CGFloat{
        set{
            var center:CGPoint=self.center
            center.x=newValue
            self.center=center
        }
        get{
            return self.center.x
        }
    }
    
    var centerY:CGFloat{
        set{
            var center:CGPoint=self.center
            center.y=newValue
            self.center=center
        }
        get{
            return self.center.y
        }
    }
    
    var width:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.size.width=newValue
            self.frame=frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    var height:CGFloat{
        set{
            var frame:CGRect=self.frame
            frame.size.height=newValue
            self.frame=frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    var size:CGSize{
        set{
            var frame:CGRect=self.frame
            frame.size=newValue
            self.frame=frame
        }
        get{
            return self.frame.size
        }
    }
    
    var origin:CGPoint{
        set{
            var frame:CGRect=self.frame
            frame.origin=newValue
            self.frame=frame
        }
        get{
            return self.frame.origin
        }
    }
    //MARK:  是否在主窗口上
    ///  是否在主窗口上
    func isShowingOnKeyWindow()->Bool{
        
        // 主窗口
        let keyWindow:UIWindow = UIApplication.sharedApplication().keyWindow!
        
        // 以主窗口左上角为坐标原点, 计算self的矩形框
        let newFrame:CGRect = keyWindow.convertRect(self.frame, fromView: self.superview)
        
        let winBounds:CGRect = keyWindow.bounds;
        // 主窗口的bounds 和 self的矩形框 是否有重叠
        /// 记录当前是否是
        let intersects: Bool = CGRectIntersectsRect(newFrame, winBounds);
        
        return (self.hidden == false) && (self.alpha > 0.01) && (self.window == keyWindow) && (intersects == true)
    }
}





extension CGSize {
    var area: CGFloat {
        return width * height
    }
}



