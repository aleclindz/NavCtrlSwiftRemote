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
    var productToSend: String!
    
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if editingStyle == .Delete {
            products.removeAtIndex(indexPath.row)
            productTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            defaults.setValue(products, forKey: companyTitle)
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        products = defaults.arrayForKey(companyTitle) as! [String]
        
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
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let tempProduct = products[sourceIndexPath.row]
        products.removeAtIndex(sourceIndexPath.row)
        products.insert(tempProduct, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        productToSend = products[indexPath.row]
        performSegueWithIdentifier("segueToWebView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToWebView" {
            let destinationVC = segue.destinationViewController as! WebViewController
            destinationVC.product = productToSend
        }
    }
    
    
    


    
}