//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Дария Григорьева on 28.10.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalValue: String?
    var info: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = totalValue
        settingsLabel.text = info
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
