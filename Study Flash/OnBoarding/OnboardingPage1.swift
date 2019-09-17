//
//  OnboardingPage1.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/24/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class OnboardingPage1: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let imageOfOnboarding = UIImageView(image: UIImage(named: "OnboardingImage1"))
        imageOfOnboarding.setOnboardingImage()

        let titleOfOnboarding = UILabel()
        titleOfOnboarding.setOnboardingTitleFormat()
        titleOfOnboarding.text = "Welcome On Board"

        let descriptionOfOnboarding = UILabel()
        descriptionOfOnboarding.setOnboardingDescription()
        descriptionOfOnboarding.text = "Here you will have an unique learning experience"

        let stackView = UIStackView()
        stackView.setOnboardingStackView()
        
        stackView.addArrangedSubview(imageOfOnboarding)
        stackView.addArrangedSubview(titleOfOnboarding)
        stackView.addArrangedSubview(descriptionOfOnboarding)
        
        stackView.setCustomSpacing(40, after: stackView.subviews[0])
        stackView.setCustomSpacing(20, after: stackView.subviews[1])
    
        addSubview(stackView)
        
        //Constraint
        imageOfOnboarding.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        imageOfOnboarding.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        //Anchor
        titleOfOnboarding.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        descriptionOfOnboarding.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        descriptionOfOnboarding.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        descriptionOfOnboarding.widthAnchor.constraint(equalToConstant: 340).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 100).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
