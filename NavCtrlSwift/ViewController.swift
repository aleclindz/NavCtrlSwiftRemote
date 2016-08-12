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
    
    func setupData(){
        
        let apple = Company(name: "Apple", imageUrl: "https://vignette2.wikia.nocookie.net/logopedia/images/2/26/Apple_2003_logo.png/revision/latest?cb=20121102224024", companyUrl: "https://www.apple.com" )
        
        let iPad = Product(name: "iPad", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b9/Apple_iPad_New_Logo_Thin_used_in_iPad_Air_Series.png", productUrl: "https://www.apple.com/ipad/")
        
        apple.products?.append(iPad)
        
        let google = Company(name: "Google", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png", companyUrl: "https://www.google.com")
        
        let gmail = Product(name: "Gmail", imageUrl: "https://www.userlogos.org/files/logos/sjdvda/gmail5.png", productUrl: "https://gmail.com")
        
        google.products?.append(gmail)
        
        let twitter = Company(name: "Twitter", imageUrl: "https://www.seeklogo.net/wp-content/uploads/2014/12/twitter-logo-vector-download.jpg", companyUrl: "https://www.twitter.com")
        
        let moments = Product(name: "Moments", imageUrl: "https://socialmediaupdatesite.files.wordpress.com/2016/03/moments.png?w=512&h=512&crop=1", productUrl: "https://twitter.com/i/moments?lang=en")
        
        twitter.products?.append(moments)
        
        let tesla = Company(name: "Tesla", imageUrl: "https://thenewswheel.com/wp-content/uploads/2015/10/Tesla-T-logo.jpg", companyUrl: "https://www.tesla.com")
        
        let modelX = Product(name: "Model X", imageUrl: "https://tctechcrunch2011.files.wordpress.com/2015/07/model-x.png", productUrl: "https://www.tesla.com/modelx")
        
        tesla.products?.append(modelX)
        
        companies = [apple, google, twitter, tesla]
    }
    
}

