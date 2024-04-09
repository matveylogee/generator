//
//  MainView.swift
//  generator
//
//  Created by Матвей on 07.03.2024.
//

import UIKit

final class MainView: UIView {
    
    private let infoLabel = UILabel()
    private let nameView = InfoView("Artist Name", type: .name)
    private let nicknameView = InfoView("Artist Nickname", type: .nickname)
    private let compositionView = InfoView("Composition", type: .composition)
    private let priceView = InfoView("Price", type: .price)
    private let photoImageView = InfoImageView(frame: .zero)
    private var experienceSegmentedControl = UISegmentedControl()
    private let previewButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        configureInfoLabel()
        configureNameView()
        configurePhotoImageView()
        configureNicknameView()
        configureCompositionView()
        configurePriceView()
        configureExperienceSegmentedControl()
        configureShareButton()
        configurePreviewButton()
        
        registerForKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getInfoText(_ viewType: ViewType) -> String {
        switch viewType {
        case .name: return nameView.getText()
        case .nickname: return nicknameView.getText()
        case .composition: return compositionView.getText()
        case .price: return priceView.getText()
        }
    }
    
    func getSegmentedIndex() -> Int {
        experienceSegmentedControl.selectedSegmentIndex
    }
    
    func setIsFailed(_ viewType: ViewType, isFailed: Bool) {
        switch viewType {
        case .name: nameView.isFailed = isFailed
        case .nickname: nicknameView.isFailed = isFailed
        case .composition: compositionView.isFailed = isFailed
        case .price: priceView.isFailed = isFailed
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Анимация перемещения view при открытии клавиатуры
            UIView.animate(withDuration: 0.3) {
                self.frame.origin.y = -keyboardSize.height + 285
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        // Анимация перемещения view при закрытии клавиатуры
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = 0
        }
    }
}

//MARK: - Setup UI

extension MainView {
    
    private func configureInfoLabel() {
        infoLabel.text = "Введите все необходимые данные"
        infoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 185),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func configureNameView() {
        addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            nameView.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12)
        ])
    }
    
    private func configurePhotoImageView() {
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 40),
            photoImageView.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 20),
            photoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
    }
    
    private func configureNicknameView() {
        addSubview(nicknameView)
        NSLayoutConstraint.activate([
            nicknameView.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 0),
            nicknameView.leadingAnchor.constraint(equalTo:  photoImageView.trailingAnchor, constant: 20),
            nicknameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nicknameView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12)
        ])
    }
    
    private func configureCompositionView() {
        addSubview(compositionView)
        NSLayoutConstraint.activate([
            compositionView.leadingAnchor.constraint(equalTo:  photoImageView.trailingAnchor, constant: 20),
            compositionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            compositionView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12),
            compositionView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0)
        ])
    }
    
    private func configurePriceView() {
        addSubview(priceView)
        NSLayoutConstraint.activate([
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            priceView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12),
        ])
    }
    
    private func configureExperienceSegmentedControl() {
        experienceSegmentedControl = UISegmentedControl(items: ["Mp3", "Wav", "Trackout"])
        experienceSegmentedControl.selectedSegmentIndex = 0
        experienceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(experienceSegmentedControl)
        NSLayoutConstraint.activate([
            experienceSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            experienceSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            experienceSegmentedControl.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureShareButton() {
        shareButton.backgroundColor = UIColor(named: "backgroundColor")
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemBlue
        shareButton.layer.borderColor = UIColor.systemBlue.cgColor
        shareButton.layer.borderWidth = 2
        shareButton.layer.cornerRadius = 10
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(nil, action: #selector(ViewController.shareButtonTapped), for: .touchUpInside)
        
        addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: experienceSegmentedControl.bottomAnchor, constant: 40),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configurePreviewButton() {
        previewButton.backgroundColor = .systemBlue
        previewButton.setTitle("Preview", for: .normal)
        previewButton.tintColor = .white
        previewButton.layer.cornerRadius = 10
        previewButton.translatesAutoresizingMaskIntoConstraints = false
        previewButton.addTarget(nil, action: #selector(ViewController.previewButtonTapped), for: .touchUpInside)
        
        addSubview(previewButton)
        NSLayoutConstraint.activate([
            previewButton.topAnchor.constraint(equalTo: experienceSegmentedControl.bottomAnchor, constant: 40),
            previewButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            previewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            previewButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
 
