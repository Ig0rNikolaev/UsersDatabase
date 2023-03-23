//
//  User+CoreDataProperties.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var data: String?
}

extension User : Identifiable {
}
