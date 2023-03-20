//
//  Builder.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 20.03.2023.
//

import UIKit

final class BuilderCharacter {
    static func build() -> UIViewController {
        let view = UserView()
        let model = UserModel()
        let presenter = UserPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
