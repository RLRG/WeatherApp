//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import UIKit
#if WeatherAppLAB
    import FLEX
#endif

class SearchViewController : UIViewController {
    
    // MARK: - Properties & Initialization
    
    @IBOutlet weak var debugButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Displaying the DEBUG button when we are running the LAB target.
        #if WeatherAppLAB
            debugButton.isHidden = false
        #else
            debugButton.isHidden = true
        #endif

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction func openWebView(_ sender: Any) {
        let webViewVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController // swiftlint:disable:this force_cast
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func openFLEX(_ sender: Any) {
        // Displaying FLEX debugger.
        #if WeatherAppLAB
            FLEXManager.shared().showExplorer()
        #endif
    }
    
}
