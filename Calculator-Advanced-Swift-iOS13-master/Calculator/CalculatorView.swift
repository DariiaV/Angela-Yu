//
//  CalculatorView.swift
//  Calculator
//
//  Created by Дария Григорьева on 12.12.2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit

protocol CalculatorViewDelegate: AnyObject {
    func calcButtonPressed(_ name: String?)
    func numButtonPressed(_ name: String?)
}

final class CalculatorView: UIView {
    
    weak var delegate: CalculatorViewDelegate?
    private var isFinishedTypingNumber = true
    private var text = ""
    private var result: Double = 0
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    private let resultView = UIView()
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 50, weight: .thin)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private lazy var firstBlockStackView = createStackView()
    private lazy var secondBlockStackView = createStackView()
    private lazy var thirdBlockStackView = createStackView()
    private lazy var forthBlockStackView = createStackView()
    private lazy var fifthBlockStackView = createStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        resultView.backgroundColor = .customDark
        setupMainStackView()
        setupResultView()
        setupFirstStackView()
        setupSecondStackView()
        setupThirdStackView()
        setupForthStackView()
        setupFifthStackView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }
    
    private func createButton(color: UIColor = .customBlue, title: String, isNumberButton: Bool = true) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        
        if isNumberButton {
            button.addTarget(self, action: #selector(didTapNumberButton(_:)), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(didTapCalcButton(_:)), for: .touchUpInside)
        }
        return button
    }
}

extension CalculatorView {
    
    private func setupMainStackView() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        mainStackView.addArrangedSubview(resultView)
        mainStackView.addArrangedSubview(firstBlockStackView)
        mainStackView.addArrangedSubview(secondBlockStackView)
        mainStackView.addArrangedSubview(thirdBlockStackView)
        mainStackView.addArrangedSubview(forthBlockStackView)
        mainStackView.addArrangedSubview(fifthBlockStackView)
    }
    
    private func setupResultView() {
        resultView.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
            resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: resultView.bottomAnchor),
        ])
    }
    
    private func setupFirstStackView() {
        
        let buttonAC = createButton(color: .darkGray, title: "AC", isNumberButton: false)
        let buttonPlusOrMinus = createButton(color: .darkGray, title: "+/-", isNumberButton: false)
        let buttonPercentages = createButton(color: .darkGray, title: "%", isNumberButton: false)
        let buttonDividing = createButton(color: .customOrange, title: "÷", isNumberButton: false)
        
        addArrangedSubviews(
            views: [buttonAC, buttonPlusOrMinus, buttonPercentages, buttonDividing],
            stackView: firstBlockStackView
        )
        
    }
    
    private func setupSecondStackView() {
        let buttonSeven = createButton(title: "7")
        let buttonEight = createButton(title: "8")
        let buttonNine = createButton(title: "9")
        let buttonMultiply = createButton(color: .customOrange, title: "x", isNumberButton: false)
        
        addArrangedSubviews(
            views: [buttonSeven, buttonEight, buttonNine, buttonMultiply],
            stackView: secondBlockStackView
        )
        
    }
    
    private func setupThirdStackView() {
        let buttonFour = createButton(title: "4")
        let buttonFive = createButton(title: "5")
        let buttonSix = createButton(title: "6")
        let buttonMinus = createButton(color: .customOrange, title: "-", isNumberButton: false)
        
        addArrangedSubviews(
            views: [buttonFour, buttonFive, buttonSix, buttonMinus],
            stackView: thirdBlockStackView
        )
        
    }
    
    private func setupForthStackView() {
        let buttonOne = createButton(title: "1")
        let buttonTwo = createButton(title: "2")
        let buttonThree = createButton(title: "3")
        let buttonPlus = createButton(color: .customOrange, title: "+", isNumberButton: false)
        
        addArrangedSubviews(
            views: [buttonOne, buttonTwo, buttonThree, buttonPlus],
            stackView: forthBlockStackView
        )
        
    }
    
    private func setupFifthStackView() {
        let buttonZero = createButton(title: "0")
        let buttonDot = createButton(title: ".")
        let buttonEqually = createButton(color: .customOrange, title: "=", isNumberButton: false)
        
        let stackView = createStackView()
        stackView.addArrangedSubview(buttonDot)
        stackView.addArrangedSubview(buttonEqually)
        
        addArrangedSubviews(
            views: [buttonZero, stackView],
            stackView: fifthBlockStackView
        )
    }
    
    private func addArrangedSubviews(views: [UIView], stackView: UIStackView) {
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    @objc private func didTapCalcButton(_ sender: UIButton) {
        isFinishedTypingNumber = true
        text = ""
        guard let number = Double(resultLabel.text!) else {
            fatalError("Cannot convert display label text to a Double.")
        }
        
        if let calcMethod = sender.currentTitle {
            if calcMethod == "+/-" {
                resultLabel.text = String(number * -1)
            } else if calcMethod == "AC" {
                resultLabel.text = "0"
            } else if calcMethod == "%" {
                resultLabel.text = String(number * 0.01)
            }
            
        }
    }
    
    @objc private func didTapNumberButton(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                resultLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    guard let currentResultValue = Double(resultLabel.text!) else {
                        fatalError("Cannot convert display label text to a Double.")
                    }
                    let isInt = floor(currentResultValue) == currentResultValue
                    if !isInt {
                        return
                    }
                }
                
                resultLabel.text = resultLabel.text! + numValue
            }
        }
        
    }
}

extension UIColor {
    static var customOrange: UIColor {
        return UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
    }
    
    static var customBlue: UIColor {
        return UIColor(red: 29/255, green: 155/255, blue: 246/255, alpha: 1)
    }
    
    static var customDark: UIColor {
        return UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }
    
}
