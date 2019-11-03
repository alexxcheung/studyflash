//
//  User+CoreDataProperties.swift
//  
//
//  Created by Alex Cheung on 31/10/2019.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String
    @NSManaged public var password: String
    @NSManaged public var email: String

}
