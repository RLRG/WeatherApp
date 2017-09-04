//
//  ResultViewController.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController : UIViewController {
    
    // MARK: Properties & Initialization
    
    var resultObject: WeatherResult!
    var resultImage: ImageResult!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        cityNameLabel.text = resultObject.city.name
        imageView.downloadedFrom(link: resultImage.url)
        imageIconView.image = UIImage(named: resultObject.weatherIcon)
        tempLabel.text = "\(resultObject.temperature) ºC"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction func newSearchTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
