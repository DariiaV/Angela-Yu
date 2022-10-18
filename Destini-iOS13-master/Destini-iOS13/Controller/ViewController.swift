//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var travel = Travel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }


    @IBAction func choiceMade(_ sender: UIButton) {
        travel.nextStory(sender.currentTitle!)
        
        updateUI()
    }
    
    func updateUI() {
        storyLabel.text = travel.getTravelText()
        choice1Button.setTitle(travel.getCurrentChoice().choice1, for: .normal)
        choice2Button.setTitle(travel.getCurrentChoice().choice2, for: .normal)
    }
}

