//
//  RCPagemenController.swift
//  RcUIKit_Example
//
//  Created by 姜磊 on 2020/3/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
public class RCPagemenController: UIViewController {
    public var maxShowCount : CGFloat = 5
    public var ptitleFont : UIFont = UIFont.systemFont(ofSize: 15.0)
    public var pLineHeight : CGFloat = 2
    public var titles : [String] = []
    public var childVcs : [UIViewController] = []
    public var titleBgColor : UIColor = .white
    public var selectBlock : ( (_ selectindex : Int) -> Void)?
       fileprivate lazy var pageTitleView : YMPageTitleView = {[weak self] in
        let statusHeight:CGFloat = UIScreen.main.bounds.height >= 812 ? 44 : 20
        let titleFrame = CGRect(x: 0, y: statusHeight, width:UIScreen.main.bounds.width, height: 44)
        let linew = UIScreen.main.bounds.width/(self?.maxShowCount ?? 4)-20
        let linh = self?.pLineHeight ?? 2
        let font = self?.ptitleFont ?? UIFont.systemFont(ofSize: 15.0)
        let cellw = UIScreen.main.bounds.width/(self?.maxShowCount ?? 4)
        let titleView = YMPageTitleView(frame: titleFrame, titles:  self?.titles ?? [], params: (linew,linh, font), cellWidth: cellw, cellSpace: 0, scale: 0)
          titleView.backgroundColor = self?.titleBgColor ?? UIColor.white
          titleView.delegate = self
        return titleView
           }()
       fileprivate lazy var pageContentView : YMPageContentView = {[weak self] in
       // 1.确定内容的frame
       let contentFrame = CGRect(x: 0, y: pageTitleView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - pageTitleView.frame.maxY)
       // 2.确定所有的子控制器
       let childVcs = self?.childVcs
       let contentView = YMPageContentView(frame: contentFrame, childVcs: childVcs ?? [], parentViewController: self)
       contentView.delegate = self
       return contentView
       }()
}

extension RCPagemenController {
    public convenience init(titles:[String] = [],childs:[UIViewController]=[],count:Int = 4) {
        self.init()
        self.titles = titles
        self.childVcs = childs
        self.maxShowCount = CGFloat(count)
        setUpView()
    }
    func setUpView() {
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
    }
}

extension RCPagemenController : YMPageTitleViewDelegate {
    func classTitleView(_ titleView: YMPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
        if self.selectBlock != nil {
            self.selectBlock!(index)
        }
    }
    func classTitleViewCurrentIndex(_ titleView: YMPageTitleView, currentIndex index: Int) {
        if self.selectBlock != nil {
            self.selectBlock!(index)
        }
    }
}

extension RCPagemenController:YMPageContentViewDelegate {
    func pageContentView(_ contentView: YMPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
