//
//  File.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import CoreData
import UIKit

protocol DetailPresenterInputProtocol {
    func titleButton(title: String?, userInteraction: Bool)
}

protocol DetailPresenterOutputProtocol {
    func setupSave(tabel: UITableView)
    func setupEdit(tabel: UITableView)
    func createCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    init(user: User?)
}

final class UserDetailPresenter: DetailPresenterOutputProtocol {
    var view: DetailPresenterInputProtocol?
    var user: User?
    required init(user: User?) {
        self.user = user
    }

    func createCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameUserCell.identifier,
                                                           for: indexPath) as? NameUserCell else { return UITableViewCell() }
            cell.configurationUser(user: user)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeUserCell.identifier,
                                                           for: indexPath) as? AgeUserCell else { return UITableViewCell() }
            cell.configurationUserAge(user: user)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderUserCell.identifier,
                                                           for: indexPath) as? GenderUserCell else { return UITableViewCell() }
            cell.configurationUserGender(user: user)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func setupSave(tabel: UITableView) {
        view?.titleButton(title: "Edit", userInteraction: false)

        for indexPath in tabel.indexPathsForVisibleRows ?? [] {
            if let name = tabel.cellForRow(at: indexPath) as? NameUserCell {
                user?.name = name.labelName.text
                name.labelName.isUserInteractionEnabled = false
            }
            if let data = tabel.cellForRow(at: indexPath) as? AgeUserCell {
                user?.data = data.labelData.text
                data.userDate.isUserInteractionEnabled = false
                data.userDate.isHidden = true
            }
            if let gender = tabel.cellForRow(at: indexPath) as? GenderUserCell {
                user?.gender = gender.labelGender.text
                gender.userGender.isUserInteractionEnabled = false
                gender.userGender.isHidden = true
            }
        }
        CoreDataManager.shared.saveContext()
    }

    func setupEdit(tabel: UITableView) {
        view?.titleButton(title: "Save", userInteraction: true)

        for indexPath in tabel.indexPathsForVisibleRows ?? [] {
            if let name = tabel.cellForRow(at: indexPath) as? NameUserCell {
                name.labelName.isUserInteractionEnabled = true
            }
            if let data = tabel.cellForRow(at: indexPath) as? AgeUserCell {
                data.userDate.isUserInteractionEnabled = true
                data.userDate.isHidden = false
            }
            if let gender = tabel.cellForRow(at: indexPath) as? GenderUserCell {
                gender.userGender.isUserInteractionEnabled = true
                gender.userGender.isHidden = false

            }
        }
    }
}
