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
    var imageUrl: String!
    var image: UIImage?
    var ticker: String!
    var products: [Product]?
    
    init(name: String, imageUrl: String?, ticker: String?){
        self.name = name
        
        if let myUrl = NSURL(string: imageUrl!){
            if let myData = NSData(contentsOfURL: myUrl){
                if let myImage = UIImage(data: myData){
                    self.image = myImage
                }
            }
        }
        
        self.ticker = ticker
        self.imageUrl = imageUrl
        self.products = []
    }
    
    func changeImageTo(newImageUrl: String){
        if let myUrl = NSURL(string: newImageUrl){
            if let myData = NSData(contentsOfURL: myUrl){
                if let myImage = UIImage(data: myData){
                    self.image = myImage
                }
            }
        }
    }
}