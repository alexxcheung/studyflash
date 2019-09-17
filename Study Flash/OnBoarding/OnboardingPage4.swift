//
//  OnboardingPage1.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/24/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class OnboardingPage4: UICollectionViewCell {
    
    var delegate: CustomCollectionViewCellDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        let imageOfOnboarding = UIImageView(image: UIImage(named: "OnboardingImage4"))
        imageOfOnboarding.setOnboardingImage()
        
        let titleOfOnboarding = UILabel()
        titleOfOnboarding.setOnboardingTitleFormat()
        titleOfOnboarding.text = "Performance Analysis"

        let descriptionOfOnboarding = UILabel()
        descriptionOfOnboarding.setOnboardingDescription()
        descriptionOfOnboarding.text = "Review results to know your strengths and weaknesses."

        let stackView = UIStackView()
        stackView.setOnboardingStackView()
        
        stackView.addArrangedSubview(imageOfOnboarding)
        stackView.addArrangedSubview(titleOfOnboarding)
        stackView.addArrangedSubview(descriptionOfOnboarding)
        
        stackView.setCustomSpacing(40, after: stackView.subviews[0])
        stackView.setCustomSpacing(20, after: stackView.subviews[1])

        
        let startButton = UIButton()
        startButton.backgroundColor = UIColor.purpleThemeColor
        startButton.frame = .zero
        startButton.tintColor = .white
        startButton.setTitle("Let's start", for: .normal)
        startButton.titleLabel?.lineBreakMode = .byWordWrapping
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        startButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        startButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: startButton.titleEdgeInsetBottom, right: -10)
        startButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(startButton)
        
        //adding constraint
        imageOfOnboarding.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        imageOfOnboarding.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        //Anchor
        titleOfOnboarding.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        descriptionOfOnboarding.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        descriptionOfOnboarding.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        descriptionOfOnboarding.widthAnchor.constraint(equalToConstant: 340).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 100).isActive = true
        
        startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: startButton.height).isActive = true
        
    
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        sender.flash()
        let mydata = "Anydata you want to send to the next controller"
        
        if (self.delegate != nil) {
            self.delegate.presentNewViewController(myData: mydata as AnyObject)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
