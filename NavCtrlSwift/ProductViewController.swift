//
//  ProductViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/9/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var companyTitle: String!
    var products: [String]!
    
    @IBOutlet var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyTitle = self.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: "editButtonClicked"
        )
        
        if companyTitle == "Apple" {
            products = ["iPad", "iPod Touch", "iPhone"]
        } else if companyTitle == "Google" {
            products = ["Google Docs", "Google Sheets", "GMail"]
        } else if companyTitle == "Facebook" {
            products = ["Instagram", "Whatsapp", "Parse"]
        } else if companyTitle == "Tesla" {
            products = ["Model S", "Model X", "Model 3"]
        }
        
        self.productTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            products.removeAtIndex(indexPath.row)
            productTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "productCell")
        cell.textLabel!.text = products[indexPath.row]
        return cell
    }
    
    func editButtonClicked() {
        if self.productTableView.editing {
            self.productTableView.editing = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editButtonClicked")
        } else {
            self.productTableView.editing = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "editButtonClicked")
        }
    }


    
}