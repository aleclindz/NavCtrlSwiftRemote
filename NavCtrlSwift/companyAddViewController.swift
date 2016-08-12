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

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var middleTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelButtonTapped")
        }
    
    func saveButtonTapped(){
        
        let companyName = topTextField.text
        let ticker = middleTextField.text
        let companyLogoUrl = bottomTextField.text
        
        let company = Company(name: companyName!, imageUrl: companyLogoUrl, ticker: ticker)
        
        DataAccessObject.sharedDAO.companies.append(company)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancelButtonTapped() {
        self.navigationController?.popViewControllerAnimated(true)
    }

}