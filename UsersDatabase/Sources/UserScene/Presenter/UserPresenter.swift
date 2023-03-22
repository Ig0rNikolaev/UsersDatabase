//
//  UserPresenter.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import CoreData

protocol UserViewProtocol {
    func addAlert() -> Bool
    func addController()
    func addFetchedDelegate()
}

protocol UserPresenterProtocol {
    var user: User? { get set }
    var view: UserViewProtocol { get set }
    var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> { get set }
    init(view: UserViewProtocol)
}

final class UserPresenter: UserPresenterProtocol {
    var user: User?
    var view: UserViewProtocol
    var fetchedResultController = CoreDataManager.shared.fetchedResultController(entity: "User", sortName: "name")

    required init(view: UserViewProtocol) {
        self.view = view
    }
}
