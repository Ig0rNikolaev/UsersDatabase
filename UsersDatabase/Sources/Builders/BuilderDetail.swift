//
//  BuilderDetail.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import UIKit

final class BuilderDetail {
    static func build() -> UIViewController {
        let view = DetailView()
        let presenter = DetailPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
