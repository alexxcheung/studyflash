//
//  NavigationBarViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/13/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class CustomQuestionNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarAppearance()
    }

    
    func setupNavigationBarAppearance(){

        let navigationBar = self.navigationBar
        
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .lightGray
        
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.gray]
        
    }
    

}
