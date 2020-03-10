//
//  RCAddressViewController.swift
//  RcUIKit_Example
//
//  Created by 姜磊 on 2020/3/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class RCAddressViewController: UIViewController {
    private var containV: RCAddressView!
    private var pickviewHeight :CGFloat = 200
    private var addressDic :[[String:Any]] = []
    private var titleStr : String = "请选择地址"
    private var type : RCAddressViewType = .area
    private var province : String = ""
    private var city : String = ""
    public var selectBlock:((_ pModel:RCAddressModel?,_ cModel:RCAddressModel?,_ dModel:RCAddressModel?) -> Void )?
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    private func drawView() {
        containV = RCAddressView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: pickviewHeight),type: type,province: province,city: city, title: titleStr, dict: addressDic)
        containV.selectBlock = {
            (pModel:RCAddressModel?,cModel:RCAddressModel?,dModel:RCAddressModel?) in
            if (self.selectBlock != nil) {
                self.selectBlock!(pModel,cModel,dModel)
            }
            self.hide()
        }
        containV.backOnClickCancel = {
            self.hide()
        }
        self.view.addSubview(containV)
    }
    ///点击推出
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            hide()
    }
    public override func viewDidAppear(_ animated: Bool) {
        show()
    }
}

extension RCAddressViewController {
    public convenience init(height:CGFloat = 200,title:String="请选择地址",dict:[[String : Any]]=[],type:RCAddressViewType = .area,province:String="",city:String="") {
        self.init()
        pickviewHeight = height
        addressDic = dict
        titleStr = title
        self.type = type
        self.province = province
        self.city = city
        drawView()
    }
}

extension RCAddressViewController {
    func show() {
        UIView.animate(withDuration: 0.25) {
            self.containV.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - self.pickviewHeight, width: UIScreen.main.bounds.width, height: self.pickviewHeight)
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.containV.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: self.pickviewHeight)
        }) { ( _ ) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
