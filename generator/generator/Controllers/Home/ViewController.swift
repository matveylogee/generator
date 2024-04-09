//
//  ViewController.swift
//  generator
//
//  Created by Матвей on 06.03.2024.
//

import UIKit

class ViewController: UIViewController {

    private var mainView: MainView? {
        view as? MainView
    }
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Договор"
        
        // Предупреждение о выходе с экрана Договор, в котором генерируется документ
        navigationItem.backAction = UIAction(handler: { _ in
            let controller = UIAlertController(title: "Вы уверены?", message: "Данные сотрутся", preferredStyle: .alert)
                
            let ok = UIAlertAction(title: "Хорошо", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
                
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                
            controller.addAction(cancel)
            controller.addAction(ok)
            self.present(controller, animated: true)
        })
    }
    
    /// МЕТОД ПОДЕЛИТЬСЯ ФАЙЛОМ, ВЫЗЫВАЮ ЕГО КОГДА НАЖАЛИ НА КНОПКУ "ПОДЕЛИТЬСЯ" ПРИ ГЕНЕРАЦИИ ФАЙЛА
    /// В нем методом checkInfoField() проверяю заполнены ли все текстовые поля. Если да то создаю файл pdfData с данными полученными из pdfCreator и  названием fileName
    /// Устанавливаю название файла
    /// Добавляю обработчик завершения. Когда поделился файлом сохраняю его в стек (прописан в  классе PDFFileManager в папке Home)
    /// После этого перемещаюсь на экран Меню и выскакивает уведомление что файл добавлен в Библиотеку
    @objc func shareButtonTapped() {
        
        // Определяем дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        // Проверяем поля
        if checkInfoField() {
            guard let mainView else { return }
            guard let mainImage = UIImage(named: "photo") else { return }
            
            // Получаем данные из полей
            let pdfCreator = PDFCreator(name: mainView.getInfoText(.name),
                                        nickname: mainView.getInfoText(.nickname),
                                        composition: mainView.getInfoText(.composition),
                                        price: mainView.getInfoText(.price),
                                        experience: mainView.getSegmentedIndex(),
                                        image: mainImage)
            
            // Создаем название файла из данных полученных из полей
            let fileName = dateString + " " + mainView.getInfoText(.name) + " " + mainView.getInfoText(.composition) + ".pdf"
            
            // Создаем пдф файл с данными из pdfCreator и названием fileName
            let pdfData = pdfCreator.pdfCreateData(fileName: fileName)
            
            // Путь к временному файлу
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            
            do {
                // Устанавливаем название файла
                try pdfData.write(to: tempURL)
                let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
                
                // Добавляем обработчик завершения
                activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
                    // Перемещаемся на HomeController
                    if completed {
                        
                        // Добавляем файл в базу данных
                        PDFFileManager.shared.addPDFFile(fileName: fileName, fileURL: tempURL)
                        
                        // Возвращаемся на экран Меню
                        self.navigationController?.popToRootViewController(animated: true)
                        
                        // Показываем сообщение об успешном сохранении файла и добавлении его в Библиотеку
                        self.showSavedConfirmation()
                    }
                }
                
                // Переходим на контроллер Поделиться
                present(activityViewController, animated: true)
                
            } catch {
                print("Error sharing PDF: \(error.localizedDescription)")
            }
        }
    }

    // Метод показывающий уведомление об успешном создании файла и его добавлениив в Библиотеку
    private func showSavedConfirmation() {
        let alertController = UIAlertController(title: "Документ сохранен в Библиотеку", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        // Закрываем окно через 1.5 секунду
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    /// МЕТОД ПРОСМОТР ФАЙЛА, ВЫЗЫВАЮ ЕГО КОГДА НАЖАЛИ НА КНОПКУ "PREVIEW" ПРИ ГЕНЕРАЦИИ ФАЙЛА
    /// Показывает созданный файл на отдельном экране pdfPreviewViewController
    @objc func previewButtonTapped() {
        
        // Определяем дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        if checkInfoField() {
            guard let mainView else { return }
            guard let mainImage = UIImage(named: "photo") else { return }
            
            let pdfCreator = PDFCreator(name: mainView.getInfoText(.name),
                                        nickname: mainView.getInfoText(.nickname),
                                        composition: mainView.getInfoText(.composition),
                                        price: mainView.getInfoText(.price),
                                        experience: mainView.getSegmentedIndex(),
                                        image: mainImage)
            
            // Создаем название файла из данных полученных из полей
            let fileName = dateString + " " + mainView.getInfoText(.name) + " " + mainView.getInfoText(.composition) + ".pdf"
            
//            // Создаем пдф файл с данными из pdfCreator и названием fileName
//            let pdfData = pdfCreator.pdfCreateData(fileName: fileName)
//            
//            // Путь к временному файлу
//            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            
            let pdfPreviewViewController = PDFPreviewViewController()
            pdfPreviewViewController.documentData = pdfCreator.pdfCreateData(fileName: fileName)
            
            navigationController?.pushViewController(pdfPreviewViewController, animated: true)
        }
    }
    
    /// Метод проверяющий заполнены ли все поля или нет
    private func checkInfoField() -> Bool {
        var result = true
        
        for type in ViewType.allCases {
            if mainView?.getInfoText(type) == "" {
                mainView?.setIsFailed(type, isFailed: true)
                result = false
            } else {
                mainView?.setIsFailed(type, isFailed: false)
            }
        }
        
        return result
    }
}

