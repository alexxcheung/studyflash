//
//  UIDevice.swift
//  Study Flash
//
//  Created by Alex Cheung on 12/8/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

func detectDeviceModel() -> Int {
    if UIDevice().userInterfaceIdiom == .phone {
        
        switch UIScreen.main.nativeBounds.height {
        case 1136, 1334, 1920, 2208:
            return 0
            
        case 2436, 2688, 1792:
            return 1
            
        default:
            return 2
        }
    }
    return 3
}

