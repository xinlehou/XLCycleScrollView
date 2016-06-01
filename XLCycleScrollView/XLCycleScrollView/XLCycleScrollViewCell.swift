//
//  cell.swift
//  XLCycleScrollView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 xinle. All rights reserved.
//

import UIKit



class XLCycleScrollViewCell: UICollectionViewCell {

    
    
    let descView = UILabel()
    let imageView = UIImageView()
    
    let bgV = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        addSubview(imageView)
        addSubview(bgV)
        addSubview(descView)
        
        descView.font = UIFont.systemFontOfSize(15)
        descView.textColor = UIColor.whiteColor()
        bgV.backgroundColor = UIColor.xl_colorWithCustom(0, g: 0, b: 0, alpha: 0.3)
        
        descView.frame = CGRectMake(xl_descH, 30, 100, xl_descH)
        
        
////        imageView.contentMode = .Center
//        imageView.contentMode = .ScaleAspectFill
//        imageView.layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func refresh(indexPath : NSIndexPath, info : XLCycleScrollViewInfo)  {
        
        descView.text = info.descStr
        
        
        if info.image == nil  {
            imageView.xl_setImageWithURL(info.imageUrl)
            
        }else {
            imageView.image = info.image
            
        }
        
    }
    
   
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        imageView.frame = self.bounds
        descView.frame = CGRectMake(xl_descLeftMargin, self.frame.size.height - xl_descH, self.frame.size.width - xl_descLeftMargin * 2.0 , xl_descH)
        bgV.frame = CGRectMake(0, self.frame.size.height - xl_descH, self.frame.size.width, xl_descH)
        
        
    }
    
}
