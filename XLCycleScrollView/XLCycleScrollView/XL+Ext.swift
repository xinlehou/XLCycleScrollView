//
//  UIImageView+XL.swift
//  XLCycleScrollView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 xinle. All rights reserved.
//

import UIKit
import Kingfisher


extension  UIImageView
{
    
    func xl_setImageWithURL(urlString:String?,placeholderImage:String = "imageDefault")  {
        if urlString != nil {
            let url = NSURL(string: urlString!)
            if url != nil {
                self.kf_setImageWithURL(url!, placeholderImage: UIImage(named:placeholderImage), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    

}


extension  UIColor
{
    
    /**
     设置rgba 颜色     */
    class func xl_colorWithCustom(r: CGFloat, g:CGFloat, b:CGFloat, alpha : CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    
}

extension UIImage {
    
    class func xl_imageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        CGContextSetAlpha(ref, alpha)
        CGContextSetFillColorWithColor(ref, color.CGColor)
        CGContextFillRect(ref, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
