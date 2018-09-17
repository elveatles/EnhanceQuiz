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
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 0
    var optionButtons: [UIButton] = []
    var timer: Timer?
    
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
    @IBOutlet weak var lightningModeLabel: UILabel!
    @IBOutlet weak var lightningModeSwitch: UISwitch!
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        loadGameSounds()
        
        playAgainButton.layer.cornerRadius = 10
        showStartScreen()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    /**
     Loads correct/incorrect sounds.
    */
    func loadGameSounds() {
        var path = Bundle.main.path(forResource: "music_box", ofType: "wav")
        var soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &correctSound)
        
        path = Bundle.main.path(forResource: "fail_buzzer", ofType: "wav")
        soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &incorrectSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    /**
     Show the initial screen after launch so the player can choose
     whether they want lightning mode or not.
    */
    func showStartScreen() {
        questionField.text = "Ready to take the quiz?"
        answerField.isHidden = true
        optionsStack.isHidden = true
        lightningModeLabel.isHidden = false
        lightningModeSwitch.isHidden = false
        countdownLabel.isHidden = true
        playAgainButton.setTitle("Play", for: .normal)
        playAgainButton.isHidden = false
    }
    
    /**
     Start the quiz.
    */
    func startQuiz() {
        quizManager.startQuiz()
        
        if let t = timer {
            t.invalidate()
        }
        
        // Show/hide countdown label based on whether the user chose to turn on lightning mode
        countdownLabel.isHidden = !lightningModeSwitch.isOn
        // If user chose lightning mode, start the timer.
        if lightningModeSwitch.isOn {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] callbackTimer in
                self.quizManager.secondsLeft -= 1
                self.countdownLabel.text = "\(self.quizManager.secondsLeft)"
                if self.quizManager.secondsLeft <= 0 {
                    callbackTimer.invalidate()
                    self.displayScore()
                }
            })
        }
        
        // Show/hide views
        questionField.isHidden = false
        answerField.isHidden = true
        optionsStack.isHidden = false
        countdownLabel.text = "\(quizManager.secondsLeft)"
        lightningModeLabel.isHidden = true
        lightningModeSwitch.isHidden = true
        nextRound()
    }
    
    func displayQuestion() {
        let question = quizManager.currentQuestion()
        questionField.text = question.question
        answerField.isHidden = true
        // Remove old option buttons
        for subview in optionsStack.subviews {
            subview.removeFromSuperview()
        }
        // Add option buttons
        optionButtons = []
        for option in question.options {
            let b = QuizButton(title: option)
            b.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
            optionsStack.addArrangedSubview(b)
            optionButtons.append(b)
        }
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide/reveal views
        optionsStack.isHidden = true
        lightningModeLabel.isHidden = false
        lightningModeSwitch.isHidden = false
        countdownLabel.isHidden = true
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.isHidden = false
        
        var opener = "Way to go!"
        if !quizManager.allQuestionsAsked() {
            opener = "Time ran out!"
        }
        
        questionField.text = "\(opener)\nYou got \(quizManager.correctQuestions) out of \(quizManager.questionsPerRound) correct!"
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
            AudioServicesPlaySystemSound(correctSound)
        } else {
            // Show the correct answer if an incorrect answer was chosen
            answerField.text = "Incorrect. Answer is: \(question.answer)"
            answerField.textColor = UIColor(red: 1.0, green: 157.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            AudioServicesPlaySystemSound(incorrectSound)
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
        startQuiz()
    }
    

}

