//
//  BuilderDetail.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import UIKit

final class BuilderDetail {
    static func build(user: User?) -> UIViewController {
        let view = DetailView()
        let presenter = UserDetailPresenter(user: user, view: view)
        view.presenter = presenter
        return view
    }
}
