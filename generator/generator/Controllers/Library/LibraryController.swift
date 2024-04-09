//
//  LibraryController.swift
//  generator
//
//  Created by Матвей on 23.03.2024.
//

import UIKit


class LibraryController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // Стек для хранения PDF-файлов
    private var filesStack: PDFFileManager = PDFFileManager.shared
    
    // Отфильтрованный массив файлов для поиска
    private var filteredFiles: [PDFFile] = []
    
    // Создаем UI
    let tableView = UITableView()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "Библиотека"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)]
        
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.layer.cornerRadius = 25
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = true
        
        searchBar.backgroundColor = UIColor(named: "backgroundColor")
        searchBar.layer.cornerRadius = 25
        searchBar.layer.masksToBounds = true
        
        // Регисттрируем кастомную ячейку
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        setupSearchBar()
        setupTableView()

        updateFilteredFiles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addFileToLibrary(fileName: String, fileURL: URL) {
        filesStack.addPDFFile(fileName: fileName, fileURL: fileURL) // Добавляем файл в конец стека
        updateFilteredFiles() // Обновляем массив отфильтрованных файлов
        tableView.reloadData() // Обновляем таблицу
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredFiles()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        updateFilteredFiles()
        tableView.reloadData()
    }
    
    // Выполняем поиск на названию файла в title кнопки
    func updateFilteredFiles() {
        if searchBar.text?.isEmpty ?? true {
            filteredFiles = filesStack.getAllPDFFiles()
        } else {
            let lowercasedSearchText = searchBar.text!.lowercased()
            filteredFiles = filesStack.getAllPDFFiles().filter { pdfFile in
                return pdfFile.fileName!.lowercased().contains(lowercasedSearchText)
            }
        }
        
        print(filteredFiles)
    }

}

//MARK: - Delegate

extension LibraryController {
    
    // Устанавливаем количество строк в таблице, равно количество элементов в массиве filteredFiles (массив, который получается после фильтрации строк по их названию). То есть если в поисковике ничего не вбить то filteredFiles == filesStack и будет отобращаться исходный стек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFiles.count
    }
    
    // Заполняем строки кастомными ячейками
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.delegate = self
        
        // Задаем название файла для отображения
        let pdfFile = filesStack.getAllPDFFiles()[indexPath.row]
        cell.previewCellButton.setTitle(pdfFile.fileName, for: .normal)
        cell.pdfURL = pdfFile.fileURL!
        cell.backgroundColor = UIColor(named: "tableViewColor")
        cell.layer.cornerRadius = 25
            
        // Отключаем подсветку ячейки при выборе
        cell.selectionStyle = .none
            
        return cell
    }
    
    // Здесь можно указать высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Функция удаления строки и файла из таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pdfFile = filteredFiles[indexPath.row]
            let alertController = UIAlertController(title: "Подтверждение удаления", message: "Вы уверены, что хотите удалить файл \(pdfFile.fileName ?? "")?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Да", style: .destructive) { _ in
                // Удаляем элемент из массива filesStack
                self.filesStack.deletePDFFile(with: pdfFile.fileName ?? "")

                // Обновляем отфильтрованный массив и таблицу
                self.updateFilteredFiles()
                tableView.reloadData()
            }
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }

}

extension LibraryController: CustomCellDelegate {
    
    func previewCellButtonTapped(with fileURL: URL) {
        
        // Определяем дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let mainView = MainView()
        
        let pdfCreator = PDFCreator(name: mainView.getInfoText(.name),
                                    nickname: mainView.getInfoText(.nickname),
                                    composition: mainView.getInfoText(.composition),
                                    price: mainView.getInfoText(.price),
                                    experience: mainView.getSegmentedIndex(),
                                    image: UIImage())
        
        let fileName = dateString + " " + mainView.getInfoText(.name) + " " + mainView.getInfoText(.composition) + ".pdf"
        let pdfPreviewViewController = PDFPreviewViewController()
        pdfPreviewViewController.documentData = pdfCreator.pdfCreateData(fileName: fileName)
        
        navigationController?.pushViewController(pdfPreviewViewController, animated: true)
    }
    
    func shareCellButtonTapped(with fileURL: URL) {
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

//MARK: - Setup UI

extension LibraryController {
    
    // Размещаем поисковик
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Поиск файлов"
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // Размещаем таблицу
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.bounds.height - 100)
        ])
    }
    
}
