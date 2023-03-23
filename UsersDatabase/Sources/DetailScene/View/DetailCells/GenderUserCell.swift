//
//  3.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 23.03.2023.
//

import Foundation
import UIKit

class GenderUserCell: UITableViewCell {

    static let identifier = "GenderUserCell"

    // MARK: - UI Elements

    private lazy var iconGender: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .black
        image.image = UIImage(systemName: "person.2.circle")
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

    private lazy var userGender: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    //MARK: - Lifecycle

    override init(style: GenderUserCell.CellStyle, reuseIdentifier: String?) {
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
        iconGender.image = nil
    }

    private func setupHierarchy() {
        iconConteiner.addSubview(iconGender)
        contentView.addSubview(iconConteiner)
        contentView.addSubview(userGender)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            iconConteiner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconConteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            iconConteiner.widthAnchor.constraint(equalToConstant: 30),
            iconConteiner.heightAnchor.constraint(equalToConstant: 30),

            iconGender.topAnchor.constraint(equalTo: iconConteiner.topAnchor),
            iconGender.leftAnchor.constraint(equalTo: iconConteiner.leftAnchor),
            iconGender.rightAnchor.constraint(equalTo: iconConteiner.rightAnchor),
            iconGender.bottomAnchor.constraint(equalTo: iconConteiner.bottomAnchor),

            userGender.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userGender.leftAnchor.constraint(equalTo: iconConteiner.leftAnchor, constant: 42),
            userGender.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -150),
            userGender.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
        ])
    }
}

extension GenderUserCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
}

extension GenderUserCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Male"
        case 1:
            return "Female"
        default:
            return "None"
        }
    }
}
