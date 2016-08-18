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
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var addCompanyButton: UIButton!

// MARK: Superview methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Add,
            target: self,
            action: "addButtonTapped"
        )
        
        setUpScreen()
        
        tableView.registerNib(UINib(nibName: "companyCell", bundle: nil), forCellReuseIdentifier: "companyCell")
        
        tableView.allowsSelectionDuringEditing = true
        
        self.title = "Stock Tracker"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        setUpScreen()
        self.tableView.reloadData()
    }
    
// MARK: Setup methods
    
    func setUpScreen(){

        companies = DataAccessObject.sharedDAO.companies
        let currentCompaniesCount = companies.count
        
        // If there are more than 0 companies in array, display the edit button. Otherwise don't.
        if currentCompaniesCount > 0 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .Edit,
                target: self,
                action: "editButtonTapped")
        } else {
            self.navigationItem.leftBarButtonItem = .None
        }
        
        // If there are currently 0 companies and there were previously more, hide the tableview and show instructions
        setTableViewHiddenStatus()
    }
    
// MARK: TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        let cell:companyCell = (tableView.dequeueReusableCellWithIdentifier("companyCell", forIndexPath: indexPath) as? companyCell)!
        let company = companies[indexPath.row]
        
        cell.mainLabel.text = company.name + " (\(company.ticker))"
        cell.logoImageView.image = company.image
        cell.logoImageView.contentMode = .ScaleAspectFit
        cell.logoImageView.layer.masksToBounds = true
        cell.logoImageView.autoresizingMask = .None
        cell.logoImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.logoImageView.layer.borderWidth = 1
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
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
            setUpScreen()
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
    
// MARK: Accessory methods
    
    func setTableViewHiddenStatus(){
        
        if companies.count == 0 {
            self.tableView.hidden = true
            self.addCompanyButton.hidden = false
            self.instructionsLabel.hidden = false
        } else {
            self.tableView.hidden = false
            self.addCompanyButton.hidden = true
            self.instructionsLabel.hidden = true
        }
    }
    
    @IBAction func blankAddButtonTapped(){
        addButtonTapped()
    }
}

