//
//  RCAddressView.swift
//  RcUIKit_Example
//
//  Created by 姜磊 on 2020/3/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public enum    RCAddressViewType {
    case provinces  //省份
    case city       //省份 城市
    case area       //省份 城市 地区
    case cityOnly   //只显示城市
    case areaOnly   //只显示区
}

public class RCAddressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawMyView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let leftCancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 0, width: 40, height: 40))
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return button
    }()
    private let rightCancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-56, y: 0, width: 40, height: 40))
        button.setTitle("完成", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitleColor(UIColor(red: 77/255.0, green: 151/255.0, blue: 247/255.0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return button
    }()
    private let topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        return view
    }()
    private let underLineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 39, width: UIScreen.main.bounds.size.width, height: 1))
        return view
    }()
    private let topLineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1))
        return view
    }()
    private let topTitleLable: UILabel = {
        let lable = UILabel(frame: CGRect(x: 56, y: 0, width: UIScreen.main.bounds.size.width-56-56, height: 40))
        lable.font = UIFont.systemFont(ofSize: 14.0)
        lable.textAlignment = .center
        return lable
    }()
    private var type : RCAddressViewType = .area
    private var dataArr = [RCAddressModel]()
    private var provinceArr:[RCAddressModel]?
    private var cityArr:[RCAddressModel]?
    private var districtArr:[RCAddressModel]?
    private var provinceSelectIndex : NSInteger!
    private var citySelectIndex : NSInteger!
    private var districtSelectIndex : NSInteger!
    private var pickview = UIPickerView()
    private var provinceModel : RCAddressModel?
    private var cityModel : RCAddressModel?
    private var districtModel : RCAddressModel?
    public var selectBlock:((_ pModel:RCAddressModel?,_ cModel:RCAddressModel?,_ dModel:RCAddressModel?) -> Void )?
    public var backOnClickCancel: (() -> Void)?
    public var provice:String?
    public var city:String?
    public var topHeight : CGFloat = 40
    public var rowHeight : CGFloat = 40
    public var lineClolor : UIColor = .clear
    public var titleFont : UIFont = UIFont.boldSystemFont(ofSize: 15.0)
    public var rowFont : UIFont = UIFont.systemFont(ofSize: 14.0)
    public var titleColor : UIColor = .black
    public var rowColor : UIColor = .darkText
    public var topbgViewColor : UIColor = .white
    public var pickViewBgColor : UIColor = .white
    public var titleStr : String = "请选择地址"
    private func drawMyView() {
        self.backgroundColor = topbgViewColor
        self.addSubview(pickview)
        pickview.delegate = self
        pickview.dataSource = self
        pickview.backgroundColor = pickViewBgColor
        self.addSubview(topView)
        topView.addSubview(underLineView)
        topView.addSubview(topLineView)
        topView.addSubview(topTitleLable)
        topView.addSubview(leftCancelButton)
        leftCancelButton.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
        topView.addSubview(rightCancelButton)
        rightCancelButton.addTarget(self, action: #selector(onClickSureButton), for: .touchUpInside)
//        let bundle = Bundle(for: self.classForCoder)
//        leftCancelButton.setImage(UIImage.init(contentsOfFile: bundle.path(forResource: "icon_close", ofType: "png")!), for: .normal)
        pickview.frame = CGRect(x: 0, y: topHeight, width: self.frame.size.width, height: self.frame.size.height-topHeight)
    }
    public func reloadView() {
        topLineView.backgroundColor = lineClolor
        underLineView.backgroundColor = lineClolor
        topTitleLable.text = titleStr
        topTitleLable.font = titleFont
        topTitleLable.textColor = titleColor
        pickview.reloadAllComponents()
    }
}

extension RCAddressView:UIPickerViewDelegate,UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch type {
        case .area:
            return 3
        case .city:
            return 2
        default:
            return 1
        }
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     switch type {
     case .provinces:
            return provinceArr?.count ?? 0
     case .cityOnly :
            return cityArr?.count ?? 0
     case .areaOnly:
            return districtArr?.count ?? 0
     default:
            switch component {
            case 0:
                return provinceArr?.count ?? 0
            case 1:
                return cityArr?.count ?? 0
            case 2:
                return districtArr?.count ?? 0
            default:
                return 0
            }
        }
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch type {
        case .provinces:
            provinceSelectIndex = row
            citySelectIndex = 0
        case .cityOnly:
            citySelectIndex = row
            districtSelectIndex = 0
        case .areaOnly:
            districtSelectIndex = row
        default:
            switch component {
            case 0:
                provinceSelectIndex = row
                citySelectIndex = 0
            case 1:
                citySelectIndex = row
                districtSelectIndex = 0
            case 2:
                districtSelectIndex = row
            default: break
            }
        }
        reloadData()
    }
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {        var lable = view as? UILabel
        if lable == nil {
            lable = getRowLable()
        }
        var model:RCAddressModel?
        switch type {
        case .provinces:
            model = provinceArr?[row]
        case .cityOnly:
            model = cityArr?[row]
        case .areaOnly:
            model = districtArr?[row]
        default:
            switch component {
            case 0:
                model = provinceArr?[row]
            case 1:
                model = cityArr?[row]
            case 2:
                model = districtArr?[row]
            default:
                break
            }
        }
        lable?.text = model?.title ?? ""
        return lable!
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
}

extension RCAddressView {
    /// 从plist获取全部地区数据
    private func initLocationData(dict:[[String:Any]]=[]) {
        var dataDic = dict
        if  dict.count <= 0 {
            let bundle = Bundle(for: self.classForCoder)
            guard let dictionary = NSArray(contentsOfFile: bundle.path(forResource: "rcaddress", ofType: "plist") ?? "") as? [[String:Any]] else {
                return
            }
            dataDic = dictionary
        }
        provinceSelectIndex = 0
        citySelectIndex = 0
        districtSelectIndex = 0
        var index = 0
        for item in dataDic {
            let model = RCAddressModel(dict: item)
            dataArr.append(model)
            if type == .cityOnly {
                if let prov = provice {
                    if model.title?.range(of: "\(prov)") != nil {
                        provinceSelectIndex = index
                        break
                    }
                }
            } else if type == .areaOnly {
                if let prov = provice {
                    if model.title?.range(of: "\(prov)") != nil {
                        provinceSelectIndex = index
                        var cityindex =  0
                        for cityItem in model.child ?? [] {
                            if let citystr = city {
                                if cityItem.title?.range(of: "\(citystr)") != nil {
                                    citySelectIndex = cityindex
                                    break
                                }
                            }
                            cityindex += 1
                        }
                        break
                    }
                }
            }
            index += 1
        }
        provinceArr = dataArr
        reloadData()
    }
    private func reloadData() {
        cityArr?.removeAll()
        cityModel = nil
        districtArr?.removeAll()
        districtModel = nil
        if let parr = provinceArr {
            if parr.count > 0 {
                provinceModel = parr[provinceSelectIndex]
                cityArr = provinceModel?.child
            }
        }
        if let carr = cityArr {
            if carr.count > 0 {
                cityModel = carr[citySelectIndex]
                districtArr = cityModel?.child
            }
        }
        if let darr = districtArr {
            if darr.count > 0 {
                districtModel = darr[districtSelectIndex]
            }
        }
        switch type {
        case .area:
            pickview.selectRow(citySelectIndex, inComponent: 1, animated: true)
            pickview.selectRow(districtSelectIndex, inComponent: 2, animated: true)
        case .city:
            pickview.selectRow(citySelectIndex, inComponent: 1, animated: true)
        default:
            break
        }
         pickview.reloadAllComponents()
    }
    func getRowLable() -> UILabel {
        let lable = UILabel()
        lable.font = rowFont
        lable.textAlignment = .center
        lable.textColor = rowColor
        return lable
    }
}

extension RCAddressView {
    public convenience init(frame: CGRect,type:RCAddressViewType = .area,province:String = "",city:String = "",title:String="请选择地址",dict:[[String:Any]]=[],rowHeight:CGFloat=40,rowFont:UIFont = UIFont.boldSystemFont(ofSize: 14.0),rowColor:UIColor = .black,titleFont:UIFont=UIFont.boldSystemFont(ofSize: 15.0),titleColor:UIColor = .black,lineColor:UIColor = .clear) {
        self.init(frame: frame)
        titleStr = title
        self.rowHeight = rowHeight
        self.rowFont = rowFont
        self.rowColor = rowColor
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.lineClolor = lineColor
        self.type = type
        self.provice = province
        self.city = city
        initLocationData(dict: dict)
        reloadView()
    }
    @objc private func onClickCancelButton() {
        if self.backOnClickCancel != nil {
            backOnClickCancel!()
        }
    }
    @objc private func onClickSureButton() {
        if let block = selectBlock {
            block(provinceModel,cityModel,districtModel)
        }
    }
}
