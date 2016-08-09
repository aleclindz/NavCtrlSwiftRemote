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
    var productImages: [String: UIImage]!
    
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
        
        setupData()
      
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
        let product = products[indexPath.row]
        cell.textLabel!.text = product
        cell.imageView!.image = productImages[product]
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

    func setupData(){
        
        if companyTitle == "Apple" {
            products = ["iPad", "iPod Touch", "Mac"]
        } else if companyTitle == "Google" {
            products = ["Docs", "Sheets", "Gmail"]
        } else if companyTitle == "Twitter" {
            products = ["Crashlytics", "Periscope", "Moments"]
        } else if companyTitle == "Tesla" {
            products = ["Model S", "Model X", "Model 3"]
        }
        
        productImages = [String: UIImage]()
        
        for product in products {
            if let imageToAdd = UIImage(contentsOfFile: "/Users/alexanderlindsay/Documents/Programming/TurnToTech/NavCtrlSwift/Product Images/img-Product-" + companyTitle + product + ".jpeg") {
                productImages.updateValue(imageToAdd, forKey: product)
            } else if let imageToAdd = UIImage(contentsOfFile: "/Users/alexanderlindsay/Documents/Programming/TurnToTech/NavCtrlSwift/Product Images/img-Product-" + companyTitle + product + ".png") {
                productImages.updateValue(imageToAdd, forKey: product)
            } else if let imageToAdd = UIImage(contentsOfFile: "/Users/alexanderlindsay/Documents/Programming/TurnToTech/NavCtrlSwift/Product Images/img-Product-" + companyTitle + product + ".jpg") {
                productImages.updateValue(imageToAdd, forKey: product)
            }
        }
    }

    
}