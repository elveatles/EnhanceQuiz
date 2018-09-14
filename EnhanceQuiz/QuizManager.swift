//
//  QuizManager.swift
//  EnhanceQuiz
//
//  Created by Erik Carlson on 9/14/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import GameKit

/// Manages the question and answer process of taking a Quiz.
class QuizManager {
    let questionsPerRound = 4
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var quiz = Quiz()
    
    /// Initialize with a Quiz ready to go
    init() {
        startQuiz()
    }
    
    /**
     Sets up a quiz and starts the question/answer process from the beginning.
     
     Shuffles all of the questions so they are not asked in the same order every time.
    */
    func startQuiz() {
        indexOfSelectedQuestion = 0
        correctQuestions = 0
        // Shuffle all the questions
        quiz.availableQuestions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: quiz.availableQuestions) as! [Question]
    }
    
    /**
     Get the current question being asked.
     
     - Returns: The current question.
    */
    func currentQuestion() -> Question {
        return quiz.availableQuestions[indexOfSelectedQuestion]
    }
    
    /**
     Check if an answer to the current question is correct.
     
     - Parameter answer: The answer chosen by the user.
     - Returns: true if the answer was correct. Otherwise false.
    */
    func checkAnswer(_ answer: String) -> Bool {
        let result = currentQuestion().answer == answer
        if result {
            correctQuestions += 1
        }
        indexOfSelectedQuestion += 1
        return result
    }
    
    /**
     Check if all questions in the quiz have been asked.
     
     - Returns: true if the end of the quiz has been reached. false if there are more questions to ask.
    */
    func allQuestionsAsked() -> Bool {
        return indexOfSelectedQuestion >= questionsPerRound
    }
}
