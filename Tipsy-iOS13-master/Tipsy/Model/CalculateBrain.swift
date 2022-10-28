//
//  CalculateBrain.swift
//  Tipsy
//
//  Created by Дария Григорьева on 28.10.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CalculateBrain {
    private var tipValue: Double = 0.1
    private var stepperValue: Int = 2
    private var resultValue: Double = 0
    
    func getInfoText() -> String {
        return "Split between \(stepperValue) people, with \(Int(tipValue * 100))% tip."
    }
    
    mutating func changeTipValue(tag: Int) {
        if tag == 0 {
            tipValue = 0.0
        } else if tag == 1 {
            tipValue = 0.1
        } else {
            tipValue = 0.2
        }
    }
    
    mutating func getStepperText(value: Double) -> String {
        stepperValue = Int(value)
        return String(format: "%.0f", value)
    }
    
    mutating func calculateResult(billText: String) {
        let textValue = Double(billText) ?? 0
        resultValue = textValue * (1.0 + tipValue) / Double(stepperValue)
        
    }
    
    func getResultText() -> String {
        String(format: "%.2f", resultValue)
    }
}

