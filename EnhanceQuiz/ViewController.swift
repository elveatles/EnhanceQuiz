//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var gameSound: SystemSoundID = 0
    var optionButtons: [UIButton] = []
    let optionButtonHeight: CGFloat = 40
    
    /*
     Starter implementation:
     
    let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    */
    
    let quizManager = QuizManager()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizManager.startQuiz()
        
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
        let question = quizManager.currentQuestion()
        questionField.text = question.question
        answerField.isHidden = true
        // Add option buttons
        for view in optionsStack.subviews {
            view.removeFromSuperview()
        }
        optionButtons = []
        for option in question.options {
            let b = QuizButton(title: option)
            b.heightAnchor.constraint(equalToConstant: optionButtonHeight).isActive = true
            b.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
            optionsStack.addArrangedSubview(b)
            optionButtons.append(b)
        }
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(quizManager.correctQuestions) out of \(quizManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        if quizManager.allQuestionsAsked() {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @objc func checkAnswer(_ sender: UIButton) {
        let question = quizManager.currentQuestion()
        let correct = quizManager.checkAnswer(sender.currentTitle!)
        answerField.isHidden = false
        if correct {
            // Show "Correct!" if correct answer was chosen
            answerField.text = "Correct!"
            answerField.textColor = UIColor(red: 0.0, green: 152.0/255.0, blue: 138.0/255.0, alpha: 1.0)
        } else {
            // Show the correct answer if an incorrect answer was chosen
            answerField.text = "Incorrect. Answer is: \(question.answer)"
            answerField.textColor = UIColor(red: 1.0, green: 87.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        }
        
        // Dim all buttons except for the one that was selected
        for optionButton in optionsStack.subviews as! [UIButton] {
            optionButton.backgroundColor = UIColor(red: 0.0, green: 62.0/255.0, blue: 85.0/255.0, alpha: 1.0)
            var titleColor = UIColor(red: 63.0/255.0, green: 96.0/255.0, blue: 111.0/255.0, alpha: 1.0)
            if optionButton == sender {
                titleColor = UIColor.white
            }
            optionButton.setTitleColor(titleColor, for: .normal)
        }
        
        loadNextRound(delay: 2)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        quizManager.startQuiz()
        nextRound()
    }
    

}

