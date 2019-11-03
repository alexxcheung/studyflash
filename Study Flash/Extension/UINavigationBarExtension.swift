//
//  UINavigationBarExtension.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/30/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
