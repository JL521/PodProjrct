//
//  RCAddressModel.swift
//  RcUIKit_Example
//
//  Created by 姜磊 on 2020/3/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class RCAddressModel: NSObject {
    public var title:String?
    public var adcode:String?
    public var child:[RCAddressModel]?
    init(dict: [String:Any]) {
        title = dict["title"] as? String
        adcode = dict["ad_code"] as? String
        if let childarr = dict["child"] as? [[String:Any]] {
            child = []
            for childdic in childarr {
                let cmodl = RCAddressModel(dict: childdic)
                child?.append(cmodl)
            }
        }
    }

}
