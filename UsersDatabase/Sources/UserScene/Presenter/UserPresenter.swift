//
//  UserPresenter.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import Foundation

protocol UserViewProtocol {
    func addUserName()
}

protocol UserPresenterProtocol {
    var view: UserViewProtocol { get set }
    var model: ModelProtocol { get set }
    init(view: UserViewProtocol, model: ModelProtocol)
}

class UserPresenter: UserPresenterProtocol {
    var view: UserViewProtocol
    var model: ModelProtocol

    required init(view: UserViewProtocol, model: ModelProtocol) {
        self.view = view
        self.model = model
    }
}
