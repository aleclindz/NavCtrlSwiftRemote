//
//  Product.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/12/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    var name: String!
    var image: UIImage?
    var url: NSURL?
    var productUrl: String?
    var imageUrl: String?

    init (name: String, imageUrl: String?, productUrl: String?) {
        self.name = name
        
        if let myUrl = NSURL(string: imageUrl!){
            if let myData = NSData(contentsOfURL: myUrl){
                if let myImage = UIImage(data: myData){
                    self.image = myImage
                }
            }
        }
        
        self.imageUrl = imageUrl

        if let url = NSURL(string: productUrl!){
            self.url = url
        }
        
        self.productUrl = productUrl
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