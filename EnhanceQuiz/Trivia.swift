//
//  Trivia.swift
//  EnhanceQuiz
//
//  Created by Erik Carlson on 9/13/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

struct Trivia {
    let items = [
        TriviaItem(question: "Only female koalas can whistle", answer: "False"),
        TriviaItem(question: "Blue whales are technically whales", answer: "True"),
        TriviaItem(question: "Camels are cannibalistic", answer: "False"),
        TriviaItem(question: "All ducks are birds", answer: "True")
    ]
}

struct TriviaItem {
    let question: String
    let answer: String
}
