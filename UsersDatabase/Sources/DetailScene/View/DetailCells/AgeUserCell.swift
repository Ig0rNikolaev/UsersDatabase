//
//  2.swift
//  UsersDatabase
//
//  Created by Игорь Николаев on 23.03.2023.
//

import Foundation
import UIKit

class AgeUserCell: UITableViewCell {

    static let identifier = "AgeUserCell"

    // MARK: - UI Elements

    private lazy var iconAge: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .black
        image.image = UIImage(systemName: "calendar.circle")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var iconConteiner: UIView = {
        var conteiner = UIView()
        conteiner.clipsToBounds = true
        conteiner.layer.cornerRadius = 5
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        return conteiner
    }()

    private lazy var userDate: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private var labelData: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "dd:mm:yy"
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Lifecycle

    @objc private func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        labelData.text = dateFormatter.string(from: sender.date)
    }

    override init(style: AgeUserCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - Setup

    private func setupHierarchy() {
        iconConteiner.addSubview(iconAge)
        contentView.addSubview(iconConteiner)
        contentView.addSubview(userDate)
        contentView.addSubview(labelData)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            iconConteiner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconConteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            iconConteiner.widthAnchor.constraint(equalToConstant: 30),
            iconConteiner.heightAnchor.constraint(equalToConstant: 30),

            iconAge.topAnchor.constraint(equalTo: iconConteiner.topAnchor),
            iconAge.leftAnchor.constraint(equalTo: iconConteiner.leftAnchor),
            iconAge.rightAnchor.constraint(equalTo: iconConteiner.rightAnchor),
            iconAge.bottomAnchor.constraint(equalTo: iconConteiner.bottomAnchor),

            userDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            userDate.widthAnchor.constraint(equalToConstant: 160),

            labelData.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelData.leftAnchor.constraint(equalTo: iconConteiner.rightAnchor, constant: 10),
        ])
    }
}
