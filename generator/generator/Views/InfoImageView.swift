//
//  InfoImageView.swift
//  generator
//
//  Created by Матвей on 07.03.2024.
//

import UIKit

final class InfoImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        image = UIImage(systemName: "person.badge.plus")
        tintColor = .white
        contentMode = .center
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
