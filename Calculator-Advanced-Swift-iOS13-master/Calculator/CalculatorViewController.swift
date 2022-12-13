//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Дария Григорьева on 12.12.2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    private let calculatorView = CalculatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .customDark
        view.addSubview(calculatorView)
        calculatorView.translatesAutoresizingMaskIntoConstraints = false
        calculatorView.delegate = self
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            calculatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calculatorView.topAnchor.constraint(equalTo: margin.topAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CalculatorViewController: CalculatorViewDelegate {
    
    // MARK: - CalculatorViewDelegate
    
    func calcButtonPressed(_ name: String?) {
        guard let name else {
            return
        }
        
        print(name)
    }
    
    func numButtonPressed(_ name: String?) {
        guard let name else {
            return
        }
        
        print(name)
    }
    
    
}
