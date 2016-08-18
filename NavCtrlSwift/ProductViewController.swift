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
    
// MARK: Declarations
    
    var company: Company!
    var products: [Product]!
    var productToSend: Product!
    var editGestureRecognizer: UILongPressGestureRecognizer!
    
    @IBOutlet var productTableView: UITableView!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var addProductButton: UIButton!
    
// MARK: Superview Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        editGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "editButtonClicked")
        editGestureRecognizer.minimumPressDuration = 2.0
        self.productTableView.addGestureRecognizer(editGestureRecognizer)
        
        self.productTableView.allowsSelectionDuringEditing = true
        
        self.title = company.name + " Products"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addProduct")
        
        self.productTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let companyIndex = DataAccessObject.sharedDAO.companies.indexOf({$0 === self.company}) {
            self.products = DataAccessObject.sharedDAO.companies[companyIndex].products!
            for product in products {
                print("\(product.name)")
            }
        }
        self.productTableView.reloadData()
        checkScreen()
    }
    
// MARK: TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let companyIndex = DataAccessObject.sharedDAO.companies.indexOf({$0 === self.company})
            products.removeAtIndex(indexPath.row)
            DataAccessObject.sharedDAO.companies[companyIndex!].products?.removeAtIndex(indexPath.row)
            productTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            checkScreen()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "productCell")
        let product = products[indexPath.row]
        cell.textLabel!.text = product.name
        cell.imageView!.image = product.image
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let tempProduct = products[sourceIndexPath.row]
        products.removeAtIndex(sourceIndexPath.row)
        products.insert(tempProduct, atIndex: destinationIndexPath.row)
    }
    
    // If the product is not in editing mode, transition to the web view.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        productToSend = products[indexPath.row]
        
        if self.productTableView.editing == false {
            performSegueWithIdentifier("segueToWebView", sender: self)
        
        // If the product is in the editing mode, transition to the edit view controller.
        } else if self.productTableView.editing == true {
            let editProductVC = self.storyboard?.instantiateViewControllerWithIdentifier("addAndEditViewController") as? addAndEditViewController!
            editProductVC?.transitionType = "EditProduct"
            editProductVC?.company = self.company
            editProductVC?.product = productToSend
            self.navigationController?.title = "Edit \(productToSend.name)"
            self.navigationController?.pushViewController(editProductVC!, animated: true)
        }
    }

// MARK: Transition Methods
    
    // Load the products into the tableview and the company's image and name / ticker into the label.
    func setupData(){
        products = company.products
        companyImageView.image = company.image
        companyNameLabel.text = company.name + " (" + company.ticker + ")"
        checkScreen()
    }
    
    // Prepare for the segue to the web view.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToWebView" {
            let destinationVC = segue.destinationViewController as! WebViewController
            destinationVC.product = productToSend
        }
    }
    
    // Method to check if the products array is empty.  If it is, hide the tableview and show the instructions.
    func checkScreen(){
        if products.count == 0 {
            productTableView.hidden = true
            instructionsLabel.hidden = false
            addProductButton.hidden = false
        } else {
            productTableView.hidden = false
            instructionsLabel.hidden = true
            addProductButton.hidden = true
        }
    }

// MARK: Button Methods
    
    // If the tableview is in edit mode already, turn edit mode off and redisplay the add target button.
    func editButtonClicked() {
        if self.productTableView.editing {
            self.productTableView.editing = false
            editGestureRecognizer.enabled = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addProduct")
          
        //If the tableview isn't in edit mode already, enable editing mode, change the 'add' button to a 'done' button and remove the gesture recognizer.
        } else {
            editGestureRecognizer.enabled = false
            self.productTableView.editing = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "editButtonClicked")
        }
    }
    
    @IBAction func addProductButtonTUOd(sender: AnyObject) {
        addProduct()
    }
    
    // Method to add products.  Instantiate the addAndEditViewController with the correct type and set the company to self.
    func addProduct(){
        let addVC = self.storyboard?.instantiateViewControllerWithIdentifier("addAndEditViewController") as? addAndEditViewController!
        addVC?.transitionType = "AddProduct"
        addVC?.company = self.company
        
        self.navigationController?.pushViewController(addVC!, animated: true)
    }
    
    


    
}