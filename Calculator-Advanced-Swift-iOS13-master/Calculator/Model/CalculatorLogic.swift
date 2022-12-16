//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Дария Григорьева on 16.12.2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

enum SignType {
    case minus
    case plus
    case division
    case multiply
}

struct CalculatorLogic {
    
    private var resultText: String?
    
    private var isFinishedTypingNumber = true
    private var isTappedEqualSign = false
    
    private var totalResult: Double = 0
    private var currentSignType = SignType.plus
    
    private var resultValue: Double {
        get {
            guard let resultText = resultText,
                  let number = Double(resultText) else {
                return 0
            }
            
            return number
        }
        
        set {
            resultText = String(newValue)
        }
    }
    
    mutating func didTapTopButton(title: String?) {
        isFinishedTypingNumber = true
        
        if let calcMethod = title {
            if calcMethod == "+/-" {
                resultValue *= -1
            } else if calcMethod == "AC" {
                resultText = "0"
                totalResult = 0
                isTappedEqualSign = false
            } else if calcMethod == "%" {
                resultValue /= 100
            }
        }
    }
    
    mutating func didTapNumberButton(title: String?) {
        isTappedEqualSign = false
        if let numValue = title {
            if isFinishedTypingNumber {
                resultText = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    if let resultText,
                       resultText.contains(numValue) {
                        return
                    }
                }
                if let newResultText = resultText {
                    resultText = newResultText + numValue
                }
            }
        }
    }
    
    mutating func didTapCalcButton(title: String?) {
        isFinishedTypingNumber = true
        switch title {
        case "÷":
            currentSignType = .division
        case "x":
            currentSignType = .multiply
        case "-":
            currentSignType = .minus
        case "+":
            currentSignType = .plus
        default:
            if isTappedEqualSign {
                return
            }
            calculate(with: currentSignType)
            return
        }
        totalResult = resultValue
    }
    
    private mutating func calculate(with type: SignType) {
        switch type {
        case .minus:
            totalResult -= resultValue
        case .plus:
            totalResult += resultValue
        case .division:
            totalResult /= resultValue
        case .multiply:
            totalResult *= resultValue
        }
        resultValue = totalResult
        isTappedEqualSign = true
    }
    
    func getResultText() -> String {
        resultText ?? "Введите число!"
    }
}
