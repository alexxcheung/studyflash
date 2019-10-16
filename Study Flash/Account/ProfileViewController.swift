//
//  AccountViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 29/9/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//
import Foundation
import UIKit

class AccountViewController: UIViewController {


    @IBAction func tapOn_LogoutButton(_ sender: Any) {
        stateManager.logState = .loggedOut
        navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    
    

    

}
