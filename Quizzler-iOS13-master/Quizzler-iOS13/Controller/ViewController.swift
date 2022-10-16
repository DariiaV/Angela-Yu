//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    @IBOutlet weak var choiceThreeButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        //                                       String - True / False
        let actualAnswer = quizBrain.checkAnswer(sender.currentTitle!)
        //             Bool  - true / false
        if actualAnswer {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
       
        quizBrain.nextQuestion()
        updateUI()
    }
    
    func updateUI() {
        progressView.progress = quizBrain.getProgressValue()
        questionLabel.text = quizBrain.getQuestionText()
        scoreLabel.text = "Score: \(quizBrain.getScore())"

        choiceOneButton.setTitle(quizBrain.getTitleForButton(0), for: .normal)
        choiceTwoButton.setTitle(quizBrain.getTitleForButton(1), for: .normal)
        choiceThreeButton.setTitle(quizBrain.getTitleForButton(2), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.choiceOneButton.backgroundColor = UIColor.clear
            self.choiceTwoButton.backgroundColor = UIColor.clear
            self.choiceThreeButton.backgroundColor = UIColor.clear
        }
    }
}


