//
//  Model.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

protocol ModelProtocol {
    var userNames: [String] { get set } 
}

class UserModel: ModelProtocol {
    var userNames: [String] = []
}
