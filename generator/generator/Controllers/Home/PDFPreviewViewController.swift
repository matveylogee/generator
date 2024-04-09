//
//  PDFPreviewViewController.swift
//  generator
//
//  Created by Матвей on 15.03.2024.
//

import UIKit
import PDFKit

final class PDFPreviewViewController: UIViewController {
    
    var documentData: Data?
    private let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(pdfView)
        pdfView.frame = view.frame
        
        if let documentData {
            pdfView.document = PDFDocument(data: documentData)
            pdfView.autoScales = true
        }
    }
}
