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
    @NSManaged public var data: String?
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
}

extension User : Identifiable {
}
