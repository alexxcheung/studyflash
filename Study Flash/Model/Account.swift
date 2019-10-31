//
//  File.swift
//  Study Flash
//
//  Created by Alex Cheung on 23/10/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation

struct Email {
    private var string: String

    init(_ string: String) throws {
        try Validations.email(string)
        self.string = string
    }

    func address() -> String {
        return string
    }
}

struct User {
    let name: String
    let email: Email
    let password: String
}


