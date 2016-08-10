//
//  WebViewController.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/10/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var product: String!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = getUrlForProduct(product)
        let nsUrl = NSURL(string: url)
        webView.loadRequest(NSURLRequest(URL: nsUrl!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func getUrlForProduct(product: String)->String{
        switch product {
        case "iPad":
            return "https://www.apple.com/ipad/"
        case "iPod Touch":
            return "https://www.apple.com/ipod-touch/"
        case "Mac":
            return "https://www.apple.com/mac/"
        case "Docs":
            return "https://www.google.com/docs/about/"
        case "Sheets":
            return "https://www.google.com/sheets/about/"
        case "Gmail":
            return "https://www.google.com/intl/en_us/mail/help/about.html"
        case "Crashlytics":
            return "https://try.crashlytics.com/"
        case "Periscope":
            return "https://www.periscope.tv/"
        case "Moments":
            return "https://twitter.com/i/moments?lang=en"
        case "Model S":
            return "https://www.tesla.com/models"
        case "Model X":
            return "https://www.tesla.com/modelx"
        case "Model 3":
            return "https://www.tesla.com/model3"
        default:
            return "https://en.wikipedia.org/wiki/Unknown"
        }
    }
    

    
    
    
}
