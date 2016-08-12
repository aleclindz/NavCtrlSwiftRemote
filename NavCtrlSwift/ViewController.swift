//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/9/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var companies: [Company]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companies = DataAccessObject.sharedDAO.companies
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: "editButtonClicked"
        )

        self.title = "Tech Companies"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            companies.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func editButtonClicked() {
        if self.tableView.editing {
            self.tableView.editing = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editButtonClicked")
            self.tableView.reloadData()
        } else {
            self.tableView.editing = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "editButtonClicked")
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let company = companies[indexPath.row]
        
        let productVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProductViewController") as? ProductViewController
        
        productVC!.company = company
        
        self.navigationController?.pushViewController(productVC!, animated: true)
    }
}

