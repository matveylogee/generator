//
//  PDFCreator.swift
//  generator
//
//  Created by Матвей on 15.03.2024.
//

import UIKit
import PDFKit

final class PDFCreator {
    let name: String
    let nickname: String
    let composition: String
    let price: String
    let experience: Int
    let image: UIImage
    
    var currentPageRect = CGRect()
    
    init(name: String, nickname: String, composition: String, price: String, experience: Int, image: UIImage) {
        self.name = name
        self.nickname = nickname
        self.composition = composition
        self.price = price
        self.experience = experience
        self.image = image
    }
}
