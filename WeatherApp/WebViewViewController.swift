//
//  WebViewViewController.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import UIKit

class WebViewViewController: UIViewController {
    
    // MARK: - Properties & Initialization
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: URL(string: Constants.webViewURL)!))
    }
    
}
