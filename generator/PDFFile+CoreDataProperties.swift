//
//  PDFDocument+CoreDataProperties.swift
//  generator
//
//  Created by Матвей on 29.03.2024.
//
//

import Foundation
import CoreData

@objc(PDFFile)
public class PDFFile: NSManagedObject {}

extension PDFFile {

    @NSManaged public var fileName: String?
    @NSManaged public var fileURL: URL?

    static func == (lhs: PDFFile, rhs: PDFFile) -> Bool {
        return lhs.fileName == rhs.fileName && lhs.fileURL == rhs.fileURL
    }
}

extension PDFFile : Identifiable {}
