//
//  Model.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import CoreData

protocol ModelProtocol {
    var userNames: [NSManagedObject] { get set }
}

class UserModel: ModelProtocol {
    var userNames: [NSManagedObject] = []
}
