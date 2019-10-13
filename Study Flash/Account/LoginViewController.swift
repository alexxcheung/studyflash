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

        // Do any additional setup after loading the view.
        
        stateManager.logState = .loggedIn
        checkLogState()
        
    }
    
    fileprivate func checkLogState() {
        //check sign in or not
        if stateManager.logState == .loggedIn {
            performSegue(withIdentifier: "goToProfilePage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
    }
    

    

}
