//
//  1.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 23.03.2023.
//

import Foundation
import UIKit

class NameUserCell: UITableViewCell {
    
    static let identifier = "NameUserCell"
    
    // MARK: - UI Elements
    
    private lazy var iconName: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .black
        image.image = UIImage(systemName: "person.crop.circle")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let iconConteiner: UIView = {
        var conteiner = UIView()
        conteiner.clipsToBounds = true
        conteiner.layer.cornerRadius = 5
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        return conteiner
    }()
    
    private var labelName: UITextField = {
        let text = UITextField()
        text.textAlignment = .left
        text.tintColor = .black
        text.isUserInteractionEnabled = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.clipsToBounds = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    //MARK: - Lifecycle
    
    override init(style: NameUserCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Setup
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconName.image = nil
    }
    
    private func setupHierarchy() {
        iconConteiner.addSubview(iconName)
        contentView.addSubview(iconConteiner)
        contentView.addSubview(labelName)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            iconConteiner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconConteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            iconConteiner.widthAnchor.constraint(equalToConstant: 30),
            iconConteiner.heightAnchor.constraint(equalToConstant: 30),
            
            iconName.topAnchor.constraint(equalTo: iconConteiner.topAnchor),
            iconName.leftAnchor.constraint(equalTo: iconConteiner.leftAnchor),
            iconName.rightAnchor.constraint(equalTo: iconConteiner.rightAnchor),
            iconName.bottomAnchor.constraint(equalTo: iconConteiner.bottomAnchor),
            
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leftAnchor.constraint(equalTo: iconConteiner.rightAnchor, constant: 10),
        ])
    }

    public func configurationUser(user: User?) {
        labelName.text = user?.name
    }

    public func editeName(newName: String, user: User?) {
        user?.name = newName
    }
}
