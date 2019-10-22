//
//  LoginViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 29/9/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateManager.logState = .loggedIn
        checkLogState()
        
        self.navigationItem.title = "Profile"
    }
    
    fileprivate func checkLogState() {
        // Check sign in or not
        if stateManager.logState == .loggedIn {
            performSegue(withIdentifier: "goToProfilePage", sender: self)
        }
    }
    

}
