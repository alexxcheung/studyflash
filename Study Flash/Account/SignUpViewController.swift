//
//  SignUpViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 31/10/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK- : Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK- : Outlet Action
    @IBAction func endEditingUsername(_ sender: Any) {
        username = usernameTextField.text
    }
    
    @IBAction func endEditingEmail(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        do {
            try self.email = Email(email)
            
            print("Valid Email")
            print(self.email)
        }   catch EvaluateError.isEmpty {
            print("it is empty")
        }   catch EvaluateError.isNotValidEmailLength {
            print("Not valid length")
        }   catch EvaluateError.isNotValidEmailAddress {
            print("Not valid Email Address")
        }   catch {
            print("someerror")
        }
    }
    
    @IBAction func endEditPassword(_ sender: Any) {
        password = passwordTextField.text
    }
    
    var username: String?
    var email: Email?
    var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    func setUpUI() {
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    func validateAllInput() -> Bool {
        if isUsernameValidated() && isPasswordValidated() && isEmailValidated() {
            return true
        } else {
            return false
        }
    }
    
    func isUsernameValidated() -> Bool {
        //check whether the username is existed in database
        return true
    }
    
    func isPasswordValidated() -> Bool {
        if passwordTextField.text == confirmPasswordTextField.text {
            return true
        } else {
            print("Alert: Passwords are not the same")
            return false
        }
    }
    
    func isEmailValidated() -> Bool {
        if email != nil {
            return true
        } else {
            return false
        }
        
    }
    
    func createAccount() {
        guard
            let username = username,
            let email = email,
            let password = password else {return}
        
        let user = User(name: username, email: email, password: password)
        
        print(user)

        sendDataToDatabase()
    }
    
    func sendDataToDatabase() {
        //send user data to database
    }
    
    @IBAction func tappedOnSubmitButton(_ sender: Any) {
        
        print(username, email, password)

        guard validateAllInput() == true else { return }

        createAccount()
        print("Account Created!")
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
