//
//  CustomCell.swift
//  generator
//
//  Created by Матвей on 23.03.2024.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func previewCellButtonTapped(with fileURL: URL)
    func shareCellButtonTapped(with fileURL: URL)
}

class CustomCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    // Создаем кнопки в ячейке
    let previewCellButton = UIButton()
    let shareCellButton = UIButton()
    var pdfURL: URL? {
        didSet {
            // Обновляем кнопки при установке нового значения pdfURL
            configurePreviewCellButton()
            configureShareCellButton()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Инициализируем pdfURL перед вызовом super.init
        self.pdfURL = nil
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Кнопка поделиться
        configureShareCellButton()
        
        // Кнопка с названием файла
        configurePreviewCellButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    func configure(with pdfURL: URL) {
    //        self.pdfURL = pdfURL
    //    }
}

//MARK: - Delegate Actions

extension CustomCell {
    
    @objc func previewCellButtonTapped() {
        
        guard let pdfURL = pdfURL else { return }
        delegate?.previewCellButtonTapped(with: pdfURL)
    }

    @objc func shareCellButtonTapped() {

        guard let pdfURL = pdfURL else { return }
        delegate?.shareCellButtonTapped(with: pdfURL)
    }
}

//MARK: - Setup UI

extension CustomCell {
    
    private func configureShareCellButton() {
        shareCellButton.backgroundColor = .white
        shareCellButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareCellButton.tintColor = .systemBlue
        shareCellButton.layer.borderColor = UIColor.systemBlue.cgColor
        shareCellButton.layer.borderWidth = 2
        shareCellButton.layer.cornerRadius = 10
        shareCellButton.translatesAutoresizingMaskIntoConstraints = false
        shareCellButton.addTarget(self, action: #selector(shareCellButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(shareCellButton)
        
        NSLayoutConstraint.activate([
            shareCellButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            shareCellButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            shareCellButton.heightAnchor.constraint(equalToConstant: 40),
            shareCellButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePreviewCellButton() {
        previewCellButton.backgroundColor = .systemBlue
        previewCellButton.tintColor = .white
        previewCellButton.layer.cornerRadius = 10
        previewCellButton.translatesAutoresizingMaskIntoConstraints = false
        previewCellButton.addTarget(self, action: #selector(previewCellButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(previewCellButton)
        
        NSLayoutConstraint.activate([
            previewCellButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            previewCellButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            previewCellButton.trailingAnchor.constraint(equalTo: shareCellButton.leadingAnchor, constant: -10),
            previewCellButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}



