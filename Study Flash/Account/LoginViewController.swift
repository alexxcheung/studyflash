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
        
        stateManager.logState = .loggedOut
        checkLogState()
        
        self.navigationItem.title = "Profile"
        
    }
    
    private func checkLogState() {
        // Check sign in or not
        if stateManager.logState == .loggedIn {
            performSegue(withIdentifier: "goToProfilePage", sender: self)
        }
    }
    
    @IBAction func tappedOnSignUpButton(_ sender: Any) {
        let vc = SignUpViewController(persistenceManager: PersistenceManager.shared)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
