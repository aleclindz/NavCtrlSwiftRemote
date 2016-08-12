//
//  dataAccessObject.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/12/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation

class DataAccessObject {
    static let sharedDAO = DataAccessObject()
    
    var companies: [Company]!
    
    let apple = Company(name: "Apple", imageUrl: "https://vignette2.wikia.nocookie.net/logopedia/images/2/26/Apple_2003_logo.png/revision/latest?cb=20121102224024", ticker: "APPL" )
    
    let iPad = Product(name: "iPad", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b9/Apple_iPad_New_Logo_Thin_used_in_iPad_Air_Series.png", productUrl: "https://www.apple.com/ipad/")
    
    let google = Company(name: "Google", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png", ticker : "GOOG")
    
    let gmail = Product(name: "Gmail", imageUrl: "https://www.userlogos.org/files/logos/sjdvda/gmail5.png", productUrl: "https://gmail.com")

    let twitter = Company(name: "Twitter", imageUrl: "https://www.seeklogo.net/wp-content/uploads/2014/12/twitter-logo-vector-download.jpg", ticker: "TWTR")
    
    let moments = Product(name: "Moments", imageUrl: "https://socialmediaupdatesite.files.wordpress.com/2016/03/moments.png?w=512&h=512&crop=1", productUrl: "https://twitter.com/i/moments?lang=en")

    let tesla = Company(name: "Tesla", imageUrl: "https://thenewswheel.com/wp-content/uploads/2015/10/Tesla-T-logo.jpg", ticker: "TSLA")
    
    let modelX = Product(name: "Model X", imageUrl: "https://tctechcrunch2011.files.wordpress.com/2015/07/model-x.png", productUrl: "https://www.tesla.com/modelx")
    
    private init() {
        apple.products?.append(iPad)
        google.products?.append(gmail)
        twitter.products?.append(moments)
        tesla.products?.append(modelX)
        companies = [apple, google, twitter, tesla]
    }
}