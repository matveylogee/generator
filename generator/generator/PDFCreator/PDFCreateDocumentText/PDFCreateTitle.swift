//
//  PDFCreateTitle.swift
//  generator
//
//  Created by Матвей on 17.03.2024.
//

import UIKit
import PDFKit

extension PDFCreator {
    
    func pdfCreateTitle(originPoint: CGPoint) -> CGPoint {

        let storage: ProducerUserDefaultsProtocol = ProducerUserDefaults()
        
        let producerName = storage.string(forKey: .producerName)
        let producerNickName = storage.string(forKey: .producerNickName)
        
        print(producerName!)
        print(producerNickName!)
        
        guard let titleTypeOfLeasing = Resources.TitleTypeOfLeasing(rawValue: experience) else {
            return CGPoint(x: 0, y: 0)
        }
        
        // Определяем дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)

        
        let nameText = addText(originPoint: originPoint,
                               text: "Лицензионное соглашение\n(НЕ ЭКСКЛЮЗИВНЫЕ ПРАВА / " + titleTypeOfLeasing.description + " Лицензия) \nЗвукозапись / Биты",
                               type: .bold,
                               size: 15,
                               color: .black)
        
        let licenceMainDescription = addText(originPoint: CGPoint(x: nameText.minX, y: nameText.maxY + 10),
                                             text: "НАСТОЯЩЕЕ ЛИЦЕНЗИОННОЕ СОГЛАШЕНИЕ заключили \(dateString) («Дата вступления в силу») " + String(name) + " (далее именуемым «Лицензиат») и между ними, также, если применимо, профессионально известным как " + String(nickname) + " и  \(producerName ?? "Бородин Матвей Вячеславович") (далее именуемый «Лицензиар»), также, если применимо, профессионально известный как \(producerNickName ?? "logee"). Лицензиар гарантирует, что он контролирует права на механическое воспроизведение музыкальных произведений, охраняемых авторским правом, под названием " + String(composition) + " («Композиция») на дату и до даты, указанной выше. Композиция, включая музыку к ней, была написана Бородиным Матвеем («Автор песен») под управлением Лицензиара.",
                                type: .regular,
                                size: 10,
                                color: .black)
        
        return CGPoint(x: licenceMainDescription.minX,
                       y: licenceMainDescription.maxY)
        
    }
}


