//
//  Company.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/12/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit

class Company {
    var name: String!
    var image: UIImage?
    var url: NSURL?
    var products: [Product]?
    
    init(name: String, imageUrl: String?, companyUrl: String?){
        self.name = name
        
        if let myUrl = NSURL(string: imageUrl!){
            if let myData = NSData(contentsOfURL: myUrl){
                if let myImage = UIImage(data: myData){
                    self.image = myImage
                }
            }
        }
        
        if let url = NSURL(string: companyUrl!){
            self.url = url
        }
        
        self.products = []
    }
}