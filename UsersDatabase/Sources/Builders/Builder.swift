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
        let presenter = UserPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
