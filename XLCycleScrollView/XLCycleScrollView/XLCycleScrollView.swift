//
//  XLCycleScrollView.swift
//  XLCycleScrollView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 xinle. All rights reserved.
//  轮播图

import UIKit


let reuseIdentifier = "XLCycleScrollViewCell"

class XLCycleScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {

    var allCount = 0
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView!
    
    let pageCon = UIPageControl()
    
    var timer : NSTimer!
    
    var dataCount = 0
    
    weak var delegate : XLCycleScrollViewDelegate?
    
        /// 是否自动滚动
    var isAutoScroll = true
        /// 自动滚动的时间间隔
    var autoScrollTimeInterval = 2.0
        /// 是否显示底部的黑色透明的bar  默认显示
    var isShowDescBar = true

        /// 只有一条数据的时候是否滚动
//    var oneDataIsScroll : Bool = false
    
    var dataArray : Array<XLCycleScrollViewInfo>!
    
    
    init(dataArray : Array<XLCycleScrollViewInfo>,  delegate : XLCycleScrollViewDelegate? ,frame: CGRect ,isAutoScroll : Bool = true ) {
        
        self.dataArray = dataArray
        self.isAutoScroll = isAutoScroll
        super.init(frame: frame)
        
        dataCount = self.dataArray.count
        pageCon.numberOfPages = dataCount
        allCount = dataCount * 1000
       
        initUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initUI()  {
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(XLCycleScrollViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView!)
        
        
        addSubview(pageCon)
        
      
        
        if isAutoScroll {
            setUpTimer()
        }

    }
    
  
    
    
    //MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = self.frame.size
        collectionView.frame = self.bounds
        
        
        
        let pageW = CGFloat(dataCount * 20)
        let pageH = xl_descH
        let pageX = self.frame.size.width - pageW
        let pageY = self.frame.size.height - pageH
        
        pageCon.frame = CGRectMake(pageX, pageY, pageW, pageH)
        
        
        if (collectionView.contentOffset.x == 0 ) {
            var targetIndex = 0;
            targetIndex = allCount / 2
           
            collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: targetIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
        }
        
    }
    
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell =   collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! XLCycleScrollViewCell
        
        cell.refresh(indexPath, info: self.dataArray[indexPath.row % dataCount])
        cell.bgV.hidden = !isShowDescBar
        
        return cell
    }
    
    
    //MARK: - ScrollView代理

    func scrollViewDidScroll(scrollView: UIScrollView) {
       
        
        let page = currentIndex() % dataCount
        pageCon.currentPage = page
        
        
    }
    
    //开始手动滚动
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        guard isAutoScroll  else {
            return
        }
        
        invalidateTimer()
        
    }
    
    //手动滚动结束
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index  = currentIndex()
       
        if index <= dataCount  || index >= allCount - dataCount  {
            
             collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: allCount / 2  , inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
        }
        
        setUpTimer()
    }
    
    
    
    
    /**
     初始化定时器
     */
    func setUpTimer()  {
        
         let timer = NSTimer(timeInterval: autoScrollTimeInterval, target: self, selector: #selector(XLCycleScrollView.autoScroll), userInfo: nil, repeats: true)
        self.timer = timer
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        
    }
    
    /**
     释放定时器
     */
    func invalidateTimer() {
        guard (timer != nil) else {
            return
        }
        timer.invalidate()
        timer = nil
    }
    
    
    //自动滚动
    func autoScroll() {
        let index = currentIndex()
        
        guard index + 1 < allCount else{
             collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: allCount / 2  , inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
            return
        }
         collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: index + 1 , inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
        
        
    }
    
    /**
     获取当前index
     */
    func currentIndex() -> Int  {
        
        guard self.frame.size.width != 0 || self.frame.size.height != 0 else {
            return 0
        }
        
        var index = 0
        if (layout.scrollDirection == .Horizontal) {
            index = Int((collectionView.contentOffset.x + layout.itemSize.width * 0.5)) / Int(layout.itemSize.width);
        } else {
            index = Int((collectionView.contentOffset.y + layout.itemSize.height * 0.5)) / Int(layout.itemSize.height);
        }
        
        return max(0, index)
    }
    
 

    
}
