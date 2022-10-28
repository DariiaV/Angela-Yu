//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
   var calculateBrain = CalculateBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTextField.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultsViewController
            resultVC.totalValue = calculateBrain.getResultText()
            resultVC.info = calculateBrain.getInfoText()
        }
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        calculateBrain.changeTipValue(tag: sender.tag)
        
        
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = calculateBrain.getStepperText(value: sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculateBrain.calculateResult(billText: billTextField.text ?? "0")
    }
    
}

extension CalculatorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let dotsCount = textField.text?.components(separatedBy: ".").count ?? 0
        if dotsCount > 1 && (string == "." || string == ",") {
            return false
        }
        
        if string == "," {
            textField.text! += "."
            return false
        }
        
        return true
    }
}
