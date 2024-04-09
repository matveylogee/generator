//
//  PDFFileManager.swift
//  generator
//
//  Created by Матвей on 28.03.2024.
//

import CoreData
import UIKit

//MARK: - CRUD
public final class PDFFileManager: NSObject {
    public static let shared = PDFFileManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func addPDFFile(fileName: String, fileURL: URL) {
        
        guard let pdfFileEntityDescription = NSEntityDescription.entity(forEntityName: "PDFFile", in: context) else { return }
        let pdfFile = PDFFile(entity: pdfFileEntityDescription, insertInto: context)
        pdfFile.fileName = fileName
        pdfFile.fileURL = fileURL
        
        appDelegate.saveContext()
    }
    
    public func getAllPDFFiles() -> [PDFFile] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PDFFile")
        
        do {
            return (try? context.fetch(fetchRequest) as? [PDFFile]) ?? []
        }
    }
    
    public func getPDFFile(with fileURL: URL) -> PDFFile? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PDFFile")
        
        do {
            let pdfFile = try? context.fetch(fetchRequest) as? [PDFFile]
            return pdfFile?.first(where: {$0.fileURL == fileURL})
        }
    }
    
    public func deleteAllPDFFile() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PDFFile")
        do {
            let pdfFile = try? context.fetch(fetchRequest) as? [PDFFile]
            pdfFile?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
    
    public func deletePDFFile(with fileName: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PDFFile")
        do {
            guard let pdfFile = try? context.fetch(fetchRequest) as? [PDFFile],
                  let pdfFile = pdfFile.first(where: {$0.fileName == fileName}) else { return }
            context.delete(pdfFile)
        }
        
        appDelegate.saveContext()
    }
}


