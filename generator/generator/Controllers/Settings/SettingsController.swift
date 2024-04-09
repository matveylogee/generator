//
//  SettingsController.swift
//  generator
//
//  Created by Матвей on 23.03.2024.
//

import UIKit

class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let settingsTableView = UITableView()
    let changePatternsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "Настройки"
        
        // Настройка заголовка navigation bar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)]
        
        settingsTableView.backgroundColor = UIColor(named: "backgroundColor")
        
        settingsTableView.register(SettingsCustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        
        setupSettingsTableView()
        configureСhangePatternsButton()
    }
}

//MARK: - Setup UI

extension SettingsController {
    
    func setupSettingsTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsTableView)
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureСhangePatternsButton() {
        changePatternsButton.backgroundColor = .systemBlue
        changePatternsButton.setTitle("Сменить данные шаблона", for: .normal)
        changePatternsButton.tintColor = .white
        changePatternsButton.layer.cornerRadius = 10
        changePatternsButton.translatesAutoresizingMaskIntoConstraints = false
        changePatternsButton.addTarget(nil, action: #selector(changePatternsButtonTapped), for: .touchUpInside)
        
        view.addSubview(changePatternsButton)
        NSLayoutConstraint.activate([
            changePatternsButton.topAnchor.constraint(equalTo: settingsTableView.bottomAnchor, constant: 77),
            changePatternsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            changePatternsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            changePatternsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//MARK: - Actions

extension SettingsController {
    @objc func changePatternsButtonTapped() {
        // Создаем экземпляр ViewController
        let changePatternsController = ChangePatternsController()
        // Переключаемся на новый экран
        navigationController?.pushViewController(changePatternsController, animated: true)
    }
}

//MARK: - Delegate

extension SettingsController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 // Установите желаемую высоту ячейки
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SettingsCustomTableViewCell
        
        // Отключаем подсветку ячейки при выборе
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "backgroundColor")
        
        if indexPath.section == 0 {
            cell.titleLabel.text = "Смена темы приложения"
            cell.switchButton.isOn = false // Установите начальное значение в зависимости от текущей темы
        } else if indexPath.section == 1 {
            cell.titleLabel.text = indexPath.row == 0 ? "Смена языка приложения" : "Смена языка договора"
            cell.switchButton.isOn = false // Установите начальное значение в зависимости от текущего языка
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Внешний вид"
        case 1:
            return "Язык"
        default:
            return nil
        }
    }
}
