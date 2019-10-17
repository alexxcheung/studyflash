//
//  UIButtonExtension.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/15/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit


extension UIButton {
    var height: CGFloat {
        if detectDeviceModel() == 0 {
            return 60
        } else {
            return 90
        }
    }
    
    var titleEdgeInsetBottom: CGFloat {
        if detectDeviceModel() == 0 {
            return -10
        } else {
            return 20
        }
    }
    
    func setupButton() {
        
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 0.5
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        layer.add(flash, forKey: nil)
    }
    
    
}


