//
//  SettingsCustomTableViewCell.swift
//  generator
//
//  Created by Матвей on 28.03.2024.
//

import UIKit

class SettingsCustomTableViewCell: UITableViewCell {
    
    // Создаем UI в ячейке
    let titleLabel = UILabel()
    let switchButton = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        
        setupSwitchButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Actions

extension SettingsCustomTableViewCell {
    @objc func switchButtonValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            MTUserDefaults.shared.setTheme(.dark)
        } else {
            MTUserDefaults.shared.setTheme(.light)
        }
    }
}

//MARK: - Setup UI

extension SettingsCustomTableViewCell {
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupSwitchButton() {
        switchButton.onTintColor = .systemBlue
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.addTarget(self, action: #selector(switchButtonValueChanged(_:)), for: .valueChanged)
        
        contentView.addSubview(switchButton)
        NSLayoutConstraint.activate([
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            switchButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}


