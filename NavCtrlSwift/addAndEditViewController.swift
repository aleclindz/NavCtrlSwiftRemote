//
//  addViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/12/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit


class addAndEditViewController: UIViewController {

    var transitionType: String!
    var company: Company?
    var product: Product?
    
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
        
        if transitionType == "AddCompany" {
            let companyName = topTextField.text
            let ticker = middleTextField.text
            let companyLogoUrl = bottomTextField.text
            let company = Company(name: companyName!, imageUrl: companyLogoUrl, ticker: ticker)
            DataAccessObject.sharedDAO.companies.append(company)
    
        } else if transitionType == "AddProduct" {
            let productName = topTextField.text
            let productUrl = middleTextField.text
            let productImageUrl = bottomTextField.text
            let productToAdd = Product(name: productName!, imageUrl: productImageUrl, productUrl: productUrl)
            if let companyIndex = DataAccessObject.sharedDAO.companies.indexOf({$0 === self.company}) {
                DataAccessObject.sharedDAO.companies[companyIndex].products?.append(productToAdd)
            }
            
        } else if transitionType == "EditCompany" {
            company!.name = topTextField.text
            company!.ticker = middleTextField.text
            company!.imageUrl = bottomTextField.text
            company?.changeImageTo((company?.imageUrl)!)
            
        } else if transitionType == "EditProduct" {
            product!.name = topTextField.text
            product!.productUrl = middleTextField.text
            product!.imageUrl = bottomTextField.text
            product!.changeImageTo(product!.imageUrl!)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancelButtonTapped() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setUpDefaults(){
        if transitionType == "AddProduct" {
            topTextField.placeholder = "Product Name"
            middleTextField.placeholder = "Product URL"
            bottomTextField.placeholder = "Product Image URL"
            self.title = "Add Product"
            
        } else if transitionType == "AddCompany" {
            topTextField.placeholder = "Company Name"
            middleTextField.placeholder = "Ticker"
            bottomTextField.placeholder = "Company Logo URL"
            self.title = "New Company"
            
        } else if transitionType == "EditCompany" {
            topTextField.text = company?.name
            middleTextField.text = company?.ticker
            bottomTextField.text = company?.imageUrl
            self.title = "Edit \(company!.name)"
            
        } else if transitionType == "EditProduct" {
            topTextField.text = product?.name
            middleTextField.text = product?.productUrl
            bottomTextField.text = product?.imageUrl
            self.title = "Edit \(product!.name)"
        }
        
    }
    
    
    
    
    
    
    
}