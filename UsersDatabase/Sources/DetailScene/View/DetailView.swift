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
        tableView.delegate = self
        tableView.register(NameUserCell.self, forCellReuseIdentifier: NameUserCell.identifier)
        tableView.register(AgeUserCell.self, forCellReuseIdentifier: AgeUserCell.identifier)
        tableView.register(GenderUserCell.self, forCellReuseIdentifier: GenderUserCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var imageUser: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.image = UIImage(systemName: "photo.circle.fill")
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
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()

    private lazy var editSaveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(editSave), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        imagePickerDelegate()
    }
    
    // MARK: - Setups

    var isSaveEdit = false {
        didSet {
            if isSaveEdit {
                self.edit()
            } else {
                    self.save()
                }
            }
        }

    @objc func editSave() {
        isSaveEdit.toggle()
    }

    @objc func addPhoto() {
        present(imagePicker, animated: true)
    }

    func edit() {
        editSaveButton.setTitle("Save", for: .normal)

        for indexPath in userTabelDetail.indexPathsForVisibleRows ?? [] {
            if let name = userTabelDetail.cellForRow(at: indexPath) as? NameUserCell {
                name.labelName.isUserInteractionEnabled = true
            }
            if let data = userTabelDetail.cellForRow(at: indexPath) as? AgeUserCell {
                data.userDate.isUserInteractionEnabled = true
                data.userDate.isHidden = false
            }
            if let gender = userTabelDetail.cellForRow(at: indexPath) as? GenderUserCell {
                gender.userGender.isUserInteractionEnabled = true
                gender.userGender.isHidden = false

            }
        }
        CoreDataManager.shared.saveContext()
    }

    func save() {
        let user = presenter?.user
        editSaveButton.setTitle("Edit", for: .normal)

        for indexPath in userTabelDetail.indexPathsForVisibleRows ?? [] {
            if let name = userTabelDetail.cellForRow(at: indexPath) as? NameUserCell {
                user?.name = name.labelName.text
                name.labelName.isUserInteractionEnabled = false
            }
            if let data = userTabelDetail.cellForRow(at: indexPath) as? AgeUserCell {
                user?.data = data.labelData.text
                data.userDate.isUserInteractionEnabled = false
                data.userDate.isHidden = true
            }
            if let gender = userTabelDetail.cellForRow(at: indexPath) as? GenderUserCell {
                user?.gender = gender.labelGender.text
                gender.userGender.isUserInteractionEnabled = false
                gender.userGender.isHidden = true
            }
        }
    }

    func imagePickerDelegate() {
        imagePicker.delegate = self
    }
    
    private func setupHierarchy() {
        imageUserСonteiner.addSubview(imageUser)
        view.addSubview(imageUserСonteiner)
        view.addSubview(userTabelDetail)
        view.addSubview(addPhotoButton)
        view.addSubview(editSaveButton)
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
            
            addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            addPhotoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -110),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 50),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 50),

            editSaveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            editSaveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            editSaveButton.widthAnchor.constraint(equalToConstant: 70),
            editSaveButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}

extension DetailView: DetailViewProtocol {
    func setupView() {
        view.backgroundColor = .systemGray6
    }
}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameUserCell.identifier,
                                                           for: indexPath) as? NameUserCell else { return UITableViewCell() }
            cell.configurationUser(user: presenter?.user)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeUserCell.identifier,
                                                           for: indexPath) as? AgeUserCell else { return UITableViewCell() }
            cell.configurationUserAge(user: presenter?.user)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderUserCell.identifier,
                                                           for: indexPath) as? GenderUserCell else { return UITableViewCell() }
            cell.configurationUserGender(user: presenter?.user)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension DetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageUser.image = image
        }
        dismiss(animated: true)
    }
}
