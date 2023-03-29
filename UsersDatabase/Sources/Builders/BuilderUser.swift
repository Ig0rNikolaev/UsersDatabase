//
//  Builder.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import UIKit

final class BuilderUser {
    static func build() -> UIViewController {
        let view = UserView()
        let presenter = UserPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
