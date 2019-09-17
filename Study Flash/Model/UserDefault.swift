//
//  UserDefault.swift
//  Study Flash
//
//  Created by Alex Cheung on 16/8/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let (nameKey, addressKey) = ("name", "address")
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var name: String
        var address: String
        
        init(_ json: [String: String]) {
            self.name = json[nameKey] ?? ""
            self.address = json[addressKey] ?? ""
        }
    }
    
    static func save(_ name: String, with address: String){
        UserDefaults.standard.set([nameKey: name, addressKey: address], forKey: userSessionKey)
    }
    
    static func getNameAndAddress()-> Model {
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
