//
//  Trivia.swift
//  EnhanceQuiz
//
//  Created by Erik Carlson on 9/13/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

/// A quiz containing a collection of questions and answers
struct Quiz {
    /// All possible questions that can be asked on a quiz
    var availableQuestions = [
        Question(
            question: "This was the only US President to serve more than two consecutive terms.",
            options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
            answer: "Franklin D. Roosevelt"),
        Question(
            question: "Which of the following countries has the most residents?",
            options: ["Nigeria", "Russia", "Iran", "Vietnam"],
            answer: "Nigeria"),
        Question(
            question: "In what year was the United Nations founded?",
            options: ["1918", "1919", "1945", "1954"],
            answer: "1945"),
        Question(
            question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
            options: ["Paris", "Washington D.C.", "New York City", "Boston"],
            answer: "New York City"),
        Question(
            question: "Which nation produces the most oil?",
            options: ["Iran", "Iraq", "Brazil", "Canada"],
            answer: "Canada"),
        Question(
            question: "Which country has most recently won consecutive World Cups in Soccer?",
            options: ["Italy", "Brazil", "Argetina", "Spain"],
            answer: "Brazil"),
        Question(
            question: "Which of the following rivers is longest?",
            options: ["Yangtze", "Mississippi", "Congo", "Mekong"],
            answer: "Mississippi"),
        Question(
            question: "Which city is the oldest?",
            options: ["Mexico City", "Cape Town", "San Juan", "Sydney"],
            answer: "Mexico City"),
        Question(
            question: "Which country was the first to allow women to vote in national elections?",
            options: ["Poland", "United States", "Sweden", "Senegal"],
            answer: "Poland"),
        Question(
            question: "Which of these countries won the most medals in the 2012 Summer Games?",
            options: ["France", "Germany", "Japan", "Great Britian"],
            answer: "Great Britian"),
        // Extra Credit: 3 Choices
        Question(
            question: "In the year 1900 in the U.S. what were the most popular first names given to boy and girl babies?",
            options: ["William and Elizabeth", "Joseph and Catherine", "John and Mary"],
            answer: "John and Mary"),
        Question(
            question: "Which of the following items was owned by the fewest U.S. homes in 1990",
            options: ["home computer", "compact disk player", "cordless phone"],
            answer: "compact disk player"),
        Question(
            question: "Who holds the record for the most victories in a row on the professional golf tour?",
            options: ["Jack Nicklaus", "Arnold Palmer", "Byron Nelson"],
            answer: "Byron Nelson"),
        Question(
            question: "Who is third behind Hank Aaron and Babe Ruth in major league career home runs?",
            options: ["Reggie Jackson", "Harmon Killebrew", "Willie Mays"],
            answer: "Willie Mays"),
    ]
}
