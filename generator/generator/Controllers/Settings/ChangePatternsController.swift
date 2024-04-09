//
//  ChangePatternsController.swift
//  generator
//
//  Created by Матвей on 01.04.2024.
//

import UIKit

class ChangePatternsController: UIViewController {
    
    private let infoLabel = UILabel()
    private let producerNameView = InfoView("Pruducer Name", type: .name)
    private let producerNicknameView = InfoView("Pruducer Nickname", type: .nickname)
    private let saveButton = UIButton(type: .system)
    
    let storage: ProducerUserDefaultsProtocol = ProducerUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        configureInfoLabel()
        configureNameView()
        configureNicknameView()
        configureSaveButton()
    }
    
    func getArtistInfoText(_ viewType: ViewType) -> String {
        switch viewType {
        case .name: return producerNameView.getText()
        case .nickname: return producerNicknameView.getText()
        case .composition: return ""
        case .price: return ""
        }
    }
    
}

//MARK: - Actions

extension ChangePatternsController {
    
    @objc func saveButtonTapped() {
        
        // Получаем текст из текстовых полей
        storage.set(producerNameView.getText(), forKey: .producerName)
        storage.set(producerNicknameView.getText(), forKey: .producerNickName)
        
        // Создаем экземпляр SettingsController
        let settingsController = SettingsController()
        
        // Передаем управление на SettingsController
        navigationController?.pushViewController(settingsController, animated: true)
        
        // Показываем уведомление с задержкой
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.showSavedConfirmation()
        }
    }
}

//MARK: - Setup UI

extension ChangePatternsController {
    
    private func configureInfoLabel() {
        infoLabel.text = "Введите все необходимые данные"
        infoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureNameView() {
        view.addSubview(producerNameView)
        NSLayoutConstraint.activate([
            producerNameView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40),
            producerNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            producerNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            producerNameView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12)
        ])
    }
    
    private func configureNicknameView() {
        view.addSubview(producerNicknameView)
        NSLayoutConstraint.activate([
            producerNicknameView.topAnchor.constraint(equalTo: producerNameView.bottomAnchor, constant: 40),
            producerNicknameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            producerNicknameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            producerNicknameView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12)
        ])
    }
 
    private func configureSaveButton() {
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitle("Сохранить изменения", for: .normal)
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(nil, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: producerNicknameView.bottomAnchor, constant: 60),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//MARK: - Methods

extension ChangePatternsController {
    
    // Метод показывающий уведомление об изменение данных
    private func showSavedConfirmation() {
        let alertController = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        // Закрываем окно через 1.5 секунду
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            alertController.dismiss(animated: true, completion: nil)
        }
        
    }
}
