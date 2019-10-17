//
//  CustomBottomButton.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/30/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class BottomNormalButton: UIButton {
    required init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = UIColor.primaryThemeColor
        self.tintColor = .white
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: self.titleEdgeInsetBottom,right: -10)
        self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
}

class BottomDisableButton: UIButton {
    required init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = UIColor.lightGray
        self.tintColor = .white
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: self.titleEdgeInsetBottom,right: -10)
        self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
}


