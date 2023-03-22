//
//  File.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import Foundation

protocol DetailViewProtocol {
    func setupView()
}

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    init(view: DetailViewProtocol?)
}

final class DetailPresenter: DetailPresenterProtocol {
    var view: DetailViewProtocol?

    required init(view: DetailViewProtocol?) {
        self.view = view
    }
}
