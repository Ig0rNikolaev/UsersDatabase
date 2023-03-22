//
//  DetailView.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 22.03.2023.
//

import UIKit

final class DetailView: UIViewController {

    var presenter: DetailPresenterProtocol?

    // MARK: - UI Elements

    private lazy var userTabelDetail: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var imageUser: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.image = UIImage(systemName: "person.circle")
        return image
    }()

    private lazy var imageUserСonteiner: UIView = {
        let image = UIView()
        image.clipsToBounds = true
        image.backgroundColor = .systemGray3
        image.layer.cornerRadius = 100
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Setups

    private func setupHierarchy() {
        imageUserСonteiner.addSubview(imageUser)
        view.addSubview(imageUserСonteiner)
        view.addSubview(userTabelDetail)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageUserСonteiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageUserСonteiner.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageUserСonteiner.widthAnchor.constraint(equalToConstant: 200),
            imageUserСonteiner.heightAnchor.constraint(equalToConstant: 200),

            imageUser.topAnchor.constraint(equalTo: imageUserСonteiner.topAnchor),
            imageUser.leftAnchor.constraint(equalTo: imageUserСonteiner.leftAnchor),
            imageUser.rightAnchor.constraint(equalTo: imageUserСonteiner.rightAnchor),
            imageUser.bottomAnchor.constraint(equalTo: imageUserСonteiner.bottomAnchor),

            userTabelDetail.topAnchor.constraint(equalTo: imageUserСonteiner.bottomAnchor, constant: 20),
            userTabelDetail.leftAnchor.constraint(equalTo: view.leftAnchor),
            userTabelDetail.rightAnchor.constraint(equalTo: view.rightAnchor),
            userTabelDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // MARK: - DetailViewProtocol

    func setupView() {
        view.backgroundColor = .systemGray6
    }

}

extension DetailView: DetailViewProtocol {}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
}

