//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Дария Григорьева on 28.10.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    private var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)
        var advice = ""
        var color: UIColor?
        if bmiValue < 18.5 {
            advice = "Eat more pies!"
            color = UIColor(named: "bmiBlue")
        } else if bmiValue >= 18.5 && bmiValue <= 24.9 {
            advice = "Fit as a fiddle!"
            color = UIColor(named: "bmiGreen")
        } else {
            advice = "Eat less pies!"
            color = UIColor(named: "bmiRed")
        }
        
        
        bmi = BMI(value: bmiValue, advice: advice, color: color)
    }
    
    func getBMIValue() -> String? {
        return String(format: "%.1f", bmi?.value ?? 0.0)
        
    }
    
    func getAdvice() -> String? {
        bmi?.advice
    }
    
    func getColor() -> UIColor? {
        bmi?.color
    }
}


