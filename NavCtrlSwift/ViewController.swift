//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/9/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var companies: [String]!
    var companyLogos: [String: UIImage]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        
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
        cell.textLabel!.text = company
        cell.imageView!.image = companyLogos[company]
        return cell
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
        } else {
            self.tableView.editing = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "editButtonClicked")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title = companies[indexPath.row]
        
        let productVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProductViewController") as? ProductViewController
        
        productVC!.title = title

        self.navigationController?.pushViewController(productVC!, animated: true)
    }
    
    func setupData(){
        
        companies = ["Apple", "Google", "Twitter", "Tesla"]
        
        companyLogos = [String: UIImage]()
        
        for company in companies {
            if let imageToAdd = UIImage(contentsOfFile: "/Users/alexanderlindsay/Documents/Programming/TurnToTech/NavCtrlSwift/Company Logos/img-companyLogo_" + company + ".png") {
                companyLogos.updateValue(imageToAdd, forKey: company)
            }
        }
    }
    
}

