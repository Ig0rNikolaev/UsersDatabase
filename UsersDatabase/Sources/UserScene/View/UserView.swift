//
//  ViewController.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 19.03.2023.
//

import UIKit

class UserView: UIViewController {

    //MARK: - Outlets

    var presenter: UserPresenterProtocol?

    //: MARK: - UI Elements

    private lazy var userNameText: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "Print your name")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var userButtonPress: UIButton = {
        let button = UIButton()
        button.setTitle("Add user", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var userTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //: MARK: - Setups

    @objc func addUser() {
        addUserName()
    }

    private func setupView() {
        title = "USERS"
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(userNameText)
        view.addSubview(userButtonPress)
        view.addSubview(userTable)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            userNameText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            userNameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            userNameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            userNameText.bottomAnchor.constraint(equalTo: userNameText.topAnchor, constant: 45),

            userButtonPress.topAnchor.constraint(equalTo: userNameText.bottomAnchor, constant: 10),
            userButtonPress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            userButtonPress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            userButtonPress.bottomAnchor.constraint(equalTo: userButtonPress.topAnchor, constant: 45),

            userTable.topAnchor.constraint(equalTo: userButtonPress.bottomAnchor, constant: 10),
            userTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            userTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            userTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.model.userNames.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.model.userNames[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension UserView: UserViewProtocol{
    func addUserName() {
        let userName = userNameText.text ?? " "
        presenter?.model.userNames.append(userName)
        userTable.reloadData()
    }
}
