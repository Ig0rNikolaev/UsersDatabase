//
//  ViewController.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 19.03.2023.
//

import UIKit
import CoreData

final class UserView: UIViewController {
    
    //MARK: - Outlets
    
    var presenter: UserPresenterOutputProtocol?
    
    //: MARK: - UI Elements
    
    lazy var userNameText: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.returnKeyType = .send
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "Ввести имя пользователя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var userButtonPress: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var userTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
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
        addController()
        addFetchedDelegate()
    }
    
    //: MARK: - Setups
    
    @objc func addUser() {
        if ((presenter?.addAlert(userName: userNameText)) != nil) {
            userNameText.text = nil
            presenter?.addSaveContext()
        }
    }
    
    private func setupView() {
        title = "КОНТАКТЫ"
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(userNameText)
        view.addSubview(userButtonPress)
        view.addSubview(userTable)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            userNameText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
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

extension UserView: UserPresenterInputProtocol {
    func addFetchedDelegate() {
        presenter?.fetchedResultController.delegate = self
    }
    
    func addController() {
        presenter?.setupController()
    }
    
    func present(alert: UIAlertController, animated: Bool) {
        present(alert, animated: animated)
    }
}

extension UserView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = presenter?.fetchedResultController.object(at: indexPath) as? User else { return }
        let view = BuilderDetail.build(user: user)
        if let sheet = view.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(view, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = presenter?.fetchedResultController.object(at: indexPath) as? User else { return }
            presenter?.addManagedContext().delete(user)
            presenter?.addSaveContext()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.fetchedResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = presenter?.fetchedResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = presenter?.fetchedResultController.object(at: indexPath) as? User
        cell = UITableViewCell(style: .value1, reuseIdentifier: "value1")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = user?.name
        return cell
    }
}

extension UserView: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        userTable.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                userTable.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let user = presenter?.fetchedResultController.object(at: indexPath) as? User
                let cell = userTable.cellForRow(at: indexPath)
                cell?.textLabel?.text = user?.name
            }
        case .move:
            if let indexPath = indexPath {
                userTable.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                userTable.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                userTable.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        userTable.endUpdates()
    }
}
