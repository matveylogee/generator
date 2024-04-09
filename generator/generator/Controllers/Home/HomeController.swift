//
//  HomeController.swift
//  generator
//
//  Created by Матвей on 23.03.2024.
//

import UIKit

class HomeController: UIViewController {

    let label = UILabel()
    let segmentedControl = UISegmentedControl(items: ["Аренда", "Эксклюзив"])
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupLabel()
        setupSegmentedControl()
        setupButton()

        title = "Меню"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)]
    }
}

//MARK: - Actions

extension HomeController {
    
    @objc func buttonTapped() {
        // Создаем экземпляр ViewController
        let viewController = ViewController()
        // Переключаемся на новый экран
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Setup UI

extension HomeController {
    
    func setupLabel() {
        label.text = "Выберите лицензию"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        // Настройка constraints для текста (расположение сверху по центру экрана)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
    
    func setupSegmentedControl() {
        // Убираем локальную переменную, используем свойство класса
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.clipsToBounds = true
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .selected)
        
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            segmentedControl.widthAnchor.constraint(equalToConstant: 280),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("Составить договор", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
                
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
