//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/9/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

// MARK: Declarations
    
    var companies: [Company]!
    
    @IBOutlet weak var tableView: UITableView!

// MARK: Superview methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.companies = DataAccessObject.sharedDAO.companies
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Edit,
            target: self,
            action: "editButtonTapped"
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Add,
            target: self,
            action: "addButtonTapped"
        )
        
        tableView.allowsSelectionDuringEditing = true
        
        self.title = "Stock Tracker"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.companies = DataAccessObject.sharedDAO.companies
        self.tableView.reloadData()
    }
    
// MARK: TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let company = companies[indexPath.row]
        cell.textLabel!.text = company.name
        cell.imageView!.image = company.image
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let tempCompany = companies[sourceIndexPath.row]
        companies.removeAtIndex(sourceIndexPath.row)
        companies.insert(tempCompany, atIndex: destinationIndexPath.row)
        DataAccessObject.sharedDAO.companies = self.companies
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            companies.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            DataAccessObject.sharedDAO.companies = self.companies
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let company = companies[indexPath.row]
        
        if self.tableView.editing == false {
            let productVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProductViewController") as? ProductViewController
            productVC!.company = company
            self.navigationController?.pushViewController(productVC!, animated: true)
            
        } else if self.tableView.editing == true {
            let editCompanyVC = self.storyboard?.instantiateViewControllerWithIdentifier("addAndEditViewController") as? addAndEditViewController!
            editCompanyVC?.transitionType = "EditCompany"
            editCompanyVC?.company = companies[indexPath.row]
            self.navigationController?.pushViewController(editCompanyVC!, animated: true)
        }
    }

// MARK: Navigation Bar Button Methods
    
    func editButtonTapped() {
        if self.tableView.editing {
            self.tableView.editing = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editButtonTapped")
            self.tableView.reloadData()
        } else {
            self.tableView.editing = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "editButtonTapped")
            self.tableView.reloadData()
        }
    }

    func addButtonTapped() {
        
        let addVC = self.storyboard?.instantiateViewControllerWithIdentifier("addAndEditViewController") as? addAndEditViewController!
        addVC?.transitionType = "AddCompany"
        self.navigationController?.pushViewController(addVC!, animated: true)
    }
    
    
}

