//
//  UserPresenter.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import CoreData
import UIKit

protocol UserPresenterInputProtocol {
    func present(alert: UIAlertController, animated: Bool)
}

protocol UserPresenterOutputProtocol {
    var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> { get set }
    func addAlert(userName: UITextField) -> Bool
    func addManagedContext() -> NSManagedObjectContext
    func addSaveContext()
    func setupController()
    init(view: UserPresenterInputProtocol)
}

final class UserPresenter: UserPresenterOutputProtocol {
    init(view: UserPresenterInputProtocol) {
        self.view = view
    }

    var view: UserPresenterInputProtocol?
    var fetchedResultController = CoreDataManager.shared.fetchedResultController(entity: "User", sortName: "name")
    var user: User?

    func addManagedContext() -> NSManagedObjectContext {
        CoreDataManager.shared.managedContext
    }

    func addSaveContext() {
        CoreDataManager.shared.saveContext()
    }

    func setupController() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }

    func addAlert(userName: UITextField) -> Bool {
        if userName.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Поле не заполнено", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            view?.present(alert: alert, animated: true)
            return false
        } else {
            user = User()
        }
        if user == nil {
            user = User(context: CoreDataManager.shared.managedContext)
        }
        if let user = user {
            user.data = "dd.mm.yy"
            user.name = userName.text
            user.gender = "None"
            addSaveContext()
        }
        return true
    }
}
