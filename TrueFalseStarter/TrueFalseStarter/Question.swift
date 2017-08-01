//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 31/07/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.
//

import Foundation
import GameplayKit

import GameplayKit

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

let questions = [
    Question(question: "Which of the following pen brands is from Japan?", correctAnswer: "Pilot", incorrectAnswers: ["Cross", "TWSBI", "Lamy"]),
    Question(question: "Which ink brand is famous for its gold flecks?", correctAnswer: "J. Herbin 1670", incorrectAnswers: ["Pilot Iroshizuku", "Robert Oster Signature"]),
    Question(question: "The Pelikan M1000 has which filling mechanism?", correctAnswer: "piston", incorrectAnswers: ["cartridge-converter", "vacuum", "eye-dropper"])
]

//questions[0].question
