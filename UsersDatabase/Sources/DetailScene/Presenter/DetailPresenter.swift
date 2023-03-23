//
//  File.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import Foundation
import CoreData

protocol DetailViewProtocol {
    func setupView()
    func imagePickerDelegate()
}

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    var user: User? { get set }
    init(view: DetailViewProtocol?, user: User?)
}

final class DetailPresenter: DetailPresenterProtocol {
    var view: DetailViewProtocol?
    var user: User?
    required init(view: DetailViewProtocol?, user: User?) {
        self.view = view
        self.user = user
    }
}
