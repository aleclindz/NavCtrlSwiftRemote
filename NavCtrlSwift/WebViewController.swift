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
    
    var product: Product!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let productUrl = product.url {
        webView.loadRequest(NSURLRequest(URL: productUrl))
        webView.allowsBackForwardNavigationGestures = true
        } else {
            let defaultUrl = NSURL(string: "http://www.jillvanderwood.com/ttr/images/shop/unknown_product.jpg")
            webView.loadRequest(NSURLRequest(URL: defaultUrl!))
            webView.allowsBackForwardNavigationGestures = false
        }
    }
    
}
