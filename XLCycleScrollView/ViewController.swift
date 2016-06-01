//
//  ViewController.swift
//  XLCycleScrollView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 xinle. All rights reserved.
//

import UIKit

public let ScreenWidth: CGFloat                                = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat                               = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect                                = UIScreen.mainScreen().bounds

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
   
        
        
//
        self.view.backgroundColor = UIColor.orangeColor()
        
        
        
        self.localImageShow()
        self.networkImageShow()
     

        
    }

    
    func localImageShow()  {
        var dataArr : Array<XLCycleScrollViewInfo> = []
        
        let descs = ["你好","哈哈","呵呵","heihie"]
        
        for index  in 1...4 {
            let  info = XLCycleScrollViewInfo(image: UIImage(named: "\(index).jpg"), imageUrl: nil, descStr:descs[index - 1] )
            dataArr.append(info)
            
        }
        let cycV = XLCycleScrollView(dataArray: dataArr, delegate: nil, frame: CGRectMake(0, 100, ScreenWidth, 200))
        
        self.view.addSubview(cycV)
    }
    
    func networkImageShow()  {
        var data1Arr : Array<XLCycleScrollViewInfo> = []
        
        let urls = ["http://imgdata.hoop8.com/1605/4751699827955.jpg"
            ,"http://imgdata.hoop8.com/1605/4651699827955.jpg"
            ,"http://imgdata.hoop8.com/1605/4571699827955.jpg"
            ,"http://imgdata.hoop8.com/1605/4441699827955.jpg"]
        
        for url  in urls {
            let  info = XLCycleScrollViewInfo(image: nil, imageUrl: url, descStr:nil)
            data1Arr.append(info)
            
        }
        
        
        let cycV1 = XLCycleScrollView(dataArray: data1Arr, delegate: nil, frame: CGRectMake(0, 350, ScreenWidth, 200))
        
        cycV1.isShowDescBar = false
        self.view.addSubview(cycV1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

