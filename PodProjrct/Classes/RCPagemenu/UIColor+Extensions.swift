//
//  UIColor+Extensions.swift
//  GZAZJ
//
//  Created by Jason on 2016/12/29.
//  Copyright © 2016年 Jason. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIColor {
    convenience init(redc : CGFloat, green : CGFloat, blue : CGFloat) {
        self.init(red: redc / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
