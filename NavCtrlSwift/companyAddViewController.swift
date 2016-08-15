//
//  addViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/12/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit


class companyAddViewController: UIViewController {

    var addType: String!
    var company: Company?
    
    @IBOutlet weak var topTextField: underlinedTextField!
    @IBOutlet weak var middleTextField: underlinedTextField!
    @IBOutlet weak var bottomTextField: underlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDefaults()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelButtonTapped")
    }
    
    func saveButtonTapped(){
        
        if addType == "Company" {
            let companyName = topTextField.text
            let ticker = middleTextField.text
            let companyLogoUrl = bottomTextField.text
            let company = Company(name: companyName!, imageUrl: companyLogoUrl, ticker: ticker)
            DataAccessObject.sharedDAO.companies.append(company)
    
        } else if addType == "Product" {
            let productName = topTextField.text
            let productUrl = middleTextField.text
            let productImageUrl = bottomTextField.text
            let productToAdd = Product(name: productName!, imageUrl: productImageUrl, productUrl: productUrl)
            if let companyIndex = DataAccessObject.sharedDAO.companies.indexOf({$0 === self.company}) {
                DataAccessObject.sharedDAO.companies[companyIndex].products?.append(productToAdd)
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancelButtonTapped() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setUpDefaults(){
        if addType == "Product" {
            topTextField.placeholder = "Product Name"
            middleTextField.placeholder = "Product URL"
            bottomTextField.placeholder = "Product Image URL"
            self.navigationController?.title = "Add Product"
        } else if addType == "Company" {
            topTextField.placeholder = "Company Name"
            middleTextField.placeholder = "Ticker"
            bottomTextField.placeholder = "Company Logo URL"
            self.navigationController?.title = "New Company"
        }
    }
    
    
    
    
    
    
    
}