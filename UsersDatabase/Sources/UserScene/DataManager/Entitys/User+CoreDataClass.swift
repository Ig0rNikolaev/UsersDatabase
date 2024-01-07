//
//  User+CoreDataClass.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//
//

import CoreData

@objc(User)
public class User: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(userName: "User"), insertInto: CoreDataManager.shared.managedContext)
    }
}
