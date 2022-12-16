//
//  CalculatorView.swift
//  Calculator
//
//  Created by Дария Григорьева on 12.12.2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit

final class CalculatorView: UIView {
    
    private enum ButtonType {
        case numbers
        case calculate
        case topButtons
    }
    
    private var isFinishedTypingNumber = true
    private var manager = CalculatorLogic()
    
    
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
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
    
    private func createButton(color: UIColor = .customBlue,
                              title: String,
                              type: ButtonType = .numbers) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        
        switch type {
        case .numbers:
            button.addTarget(self, action: #selector(didTapNumberButton(_:)), for: .touchUpInside)
        case .calculate:
            button.addTarget(self, action: #selector(didTapCalcButton(_:)), for: .touchUpInside)
        case .topButtons:
            button.addTarget(self, action: #selector(didTapTopButton(_:)), for: .touchUpInside)
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
        
        let buttonAC = createButton(color: .darkGray, title: "AC", type: .topButtons)
        let buttonPlusOrMinus = createButton(color: .darkGray, title: "+/-", type: .topButtons)
        let buttonPercentages = createButton(color: .darkGray, title: "%", type: .topButtons)
        let buttonDividing = createButton(color: .customOrange, title: "÷", type: .calculate)
        
        addArrangedSubviews(
            views: [buttonAC, buttonPlusOrMinus, buttonPercentages, buttonDividing],
            stackView: firstBlockStackView
        )
        
    }
    
    private func setupSecondStackView() {
        let buttonSeven = createButton(title: "7")
        let buttonEight = createButton(title: "8")
        let buttonNine = createButton(title: "9")
        let buttonMultiply = createButton(color: .customOrange, title: "x", type: .calculate)
        
        addArrangedSubviews(
            views: [buttonSeven, buttonEight, buttonNine, buttonMultiply],
            stackView: secondBlockStackView
        )
        
    }
    
    private func setupThirdStackView() {
        let buttonFour = createButton(title: "4")
        let buttonFive = createButton(title: "5")
        let buttonSix = createButton(title: "6")
        let buttonMinus = createButton(color: .customOrange, title: "-", type: .calculate)
        
        addArrangedSubviews(
            views: [buttonFour, buttonFive, buttonSix, buttonMinus],
            stackView: thirdBlockStackView
        )
        
    }
    
    private func setupForthStackView() {
        let buttonOne = createButton(title: "1")
        let buttonTwo = createButton(title: "2")
        let buttonThree = createButton(title: "3")
        let buttonPlus = createButton(color: .customOrange, title: "+", type: .calculate)
        
        addArrangedSubviews(
            views: [buttonOne, buttonTwo, buttonThree, buttonPlus],
            stackView: forthBlockStackView
        )
        
    }
    
    private func setupFifthStackView() {
        let buttonZero = createButton(title: "0")
        let buttonDot = createButton(title: ".")
        let buttonEqually = createButton(color: .customOrange, title: "=", type: .calculate)
        
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
        manager.didTapCalcButton(title: sender.currentTitle)
        resultLabel.text = manager.getResultText()
    }
    
    @objc private func didTapNumberButton(_ sender: UIButton) {
        manager.didTapNumberButton(title: sender.currentTitle)
        resultLabel.text = manager.getResultText()
    }
    
    @objc private func didTapTopButton(_ sender: UIButton) {
        manager.didTapTopButton(title: sender.currentTitle)
        resultLabel.text = manager.getResultText()
    }
}


