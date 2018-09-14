//
//  Question.swift
//  EnhanceQuiz
//
//  Created by Erik Carlson on 9/14/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

/// A question in a quiz that contains the question, multiple-choice options, and the correct answer.
struct Question {
    /// The question to ask.
    let question: String
    /// Multiple-choice options the user can choose from for an answer.
    let options: [String]
    /// The correct answer to the question.
    let answer: String
}
