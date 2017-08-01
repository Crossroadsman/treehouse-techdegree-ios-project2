//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 31/07/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.
//

import Foundation
import GameplayKit // for RNG

struct Question {
    //MARK: - Properties
    //------------------
    public let question: String
    private let correctAnswer: String
    private let incorrectAnswers: [String]
    
    //MARK: - Initializers
    //--------------------
    init(question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
    
    //MARK: - Methods
    //---------------
    
    /**
     tests a particular answer for correctness
     */
    public func isCorrect(answer: String) -> Bool {
        if self.correctAnswer == answer {
            return true
        } else {
            return false
        }
    }
    
    /**
     returns a randomized list of potential answers.
     */
    public func getAnswers() -> [String] {
        let randomSource = GKRandomSource()
        return randomSource.arrayByShufflingObjects(in: incorrectAnswers + [correctAnswer]) as! [String]
    }
}

let mainQuestionBank = [
    Question(question: "This was the only US President to serve more than two consecutive terms.", correctAnswer: "Franklin D. Roosevelt", incorrectAnswers: ["George Washington", "Woodrow Wilson", "Andrew Jackson"]),
    Question(question: "Which of the following countries has the most residents?", correctAnswer: "Nigeria", incorrectAnswers: ["Russia", "Iran", "Vietnam"]),
    Question(question: "In what year was the United Nations founded?", correctAnswer: "1945", incorrectAnswers: ["1918", "1919", "1954"]),
    Question(question: "The Titanic departed from United Kingdom, where was it supposed to arrive?", correctAnswer: "New York City", incorrectAnswers: ["Paris", "Boston", "Washington DC"]),
    Question(question: "Which nation produces the most oil?", correctAnswer: "Canada", incorrectAnswers: ["Iran", "Iraq", "Brazil"]),
    Question(question: "Which country has most recently won consecutive World Cups in soccer?", correctAnswer: "Brazil", incorrectAnswers: ["Italy", "Argentina", "Spain"]),
    Question(question: "Which of the following rivers is longest?", correctAnswer: "Mississippi", incorrectAnswers: ["Yangtze", "Congo", "Mekong"]),
    Question(question: "Which city is the oldest?", correctAnswer: "Mexico City", incorrectAnswers: ["Cape Town", "San Juan", "Sydney"]),
    Question(question: "Which country was the first to allow women to vote in national elections?", correctAnswer: "Poland", incorrectAnswers: ["United States", "Sweden", "Senegal"]),
    Question(question: "Which of these countries won most medals in the 2012 Olympic Summer Games", correctAnswer: "Great Britain", incorrectAnswers: ["France", "Germany", "Japan"]),
    Question(question: "Which of the following pen brands is from Japan?", correctAnswer: "Pilot", incorrectAnswers: ["Cross", "TWSBI", "Lamy"]),
    Question(question: "Which ink brand is famous for its gold flecks?", correctAnswer: "J. Herbin 1670", incorrectAnswers: ["Pilot Iroshizuku", "Robert Oster Signature"]),
    Question(question: "The Pelikan M1000 has which filling mechanism?", correctAnswer: "piston", incorrectAnswers: ["cartridge-converter", "vacuum", "eye-dropper"]),
    Question(question: "Who is now regarded as the father of the first practical fountain pen?", correctAnswer: "Lewis Edson Waterman", incorrectAnswers: ["George S Parker", "Alonzo Townsend Cross"]),
    Question(question: "What occupation did L. E. Waterman have prior to manufacturing fountain pens?", correctAnswer: "Life insurance salesman", incorrectAnswers: ["Mortician", "Private Detective"]),
    Question(question: "Before founding the Parker Pen Company, which company's pens did George Parker sell?", correctAnswer: "John Holland Gold Pen Company", incorrectAnswers: ["A. A. Waterman", "Aikin Lambert"]),
    Question(question: "In what year was the Parker 51 introduced?", correctAnswer: "1939", incorrectAnswers: ["1951", "1920"])
]

//questions[0].question
