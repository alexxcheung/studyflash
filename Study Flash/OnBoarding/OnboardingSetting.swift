//
//  OnboardingConstraint.swift
//  Study Flash
//
//  Created by Alex Cheung on 12/8/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setOnboardingTitleFormat() {
        self.frame = .zero
        self.font = UIFont(name: "AvenirNext-Bold", size: 19)
        self.textColor = .black
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setOnboardingDescription() {
        self.frame = .zero
        self.font = UIFont(name: "AvenirNext-Medium", size: 17)
        self.textColor = .black
        self.textAlignment = .center
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.sizeToFit()

        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setOnboardingTitleConstraints() {
        
    }
    
    func setOnboardingDescriptionConstraints() {
        
    }
}

extension UIStackView {
    func setOnboardingStackView() {
        self.axis = NSLayoutConstraint.Axis.vertical
        self.alignment = .center
        self.isLayoutMarginsRelativeArrangement = true
    
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    func setOnboardingImage() {
        self.contentMode = .scaleAspectFit
    }
    
    func setOnboardingImageConstraints() {
        
    }
}
