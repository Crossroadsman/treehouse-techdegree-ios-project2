//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 01/08/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameplayKit // for RNG

class Game {
    
    //MARK: - Types
    //-------------
    
    //MARK: - Properties
    //------------------
    
    private let rounds = [
        Round(type: .normal, questions: 4),
        Round(type: .lightning, questions: 4)
    ]
    
    private var questionBank: [Question] = []
    
    private var score: Int = 0
    
    private var questionIndex = 0
    private var roundIndex = 0

    
    //MARK: - Initializers
    //--------------------
    
    init() {
        
        // check that we have enough questions, else crash
        // (since there is no right way for the app to behave
        // if we insist on n unique questions, but fewer than n unique
        // questions exist, a crash is the only appropriate response
        guard let bank = getQuestions(number: rounds.reduce(0, {$0 + $1.questions}), fromBanks: [mainQuestionBank]) else {
            fatalError("Requested more questions than available")
        }
        questionBank = bank
    }
    
    
    //MARK: - Methods
    //---------------
    
    /**
     If allowDuplicates is false and the number of questions requested exceeds the number of questions in the bank, the method returns nil otherwise returns a bank of questions
     */
    private func getQuestions(number: Int, fromBanks banks: [[Question]], allowDuplicates: Bool = false) -> [Question]? {
        
        // take all the input questions banks and flatten to one single bank
        let flatBank = banks.flatMap {$0}
        
        switch allowDuplicates {
        case false where number > flatBank.count:
            return nil
        case false:
            let randomSource = GKRandomSource()
            return (randomSource.arrayByShufflingObjects(in: flatBank) as! [Question])
        case true:
            let randomSource = GKRandomSource()
            var tempBank = [Question]()
            for _ in 0 ..< number {
                let i = randomSource.nextInt(upperBound: number)
                tempBank.append(flatBank[i])
            }
            
            return tempBank
        }
        
    }
    
    public func start() {
        score = 0
        questionIndex = 0
        roundIndex = 0
    }
    
    public func getQuestionText() -> String {
        return questionBank[questionIndex].question
    }
    
    public func getAnswers() -> [String] {
        return questionBank[questionIndex].getAnswers()
    }
    
    public func isLightningRound() -> Bool {
        return rounds[roundIndex].type == .lightning
    }
    
    public func answerQuestion(answer: String) {
        
        if questionBank[questionIndex].isCorrect(answer: answer) {
            score += 1
        }
    }
    
    public func isCorrect(answer: String) -> Bool {
        
        return questionBank[questionIndex].isCorrect(answer:answer)
        
    }
    
    public func isNextRound() -> Bool {
        
        switch questionIndex {
        case _ where (questionIndex >= questionBank.count - 1) && (roundIndex == rounds.count - 1):
            // just completed last question of last round
            return false
            
        case _ where (questionIndex >= questionBank.count - 1):
            // just completed last question of round other than last round
            questionIndex += 1
            roundIndex += 1
            return true
            
        default:
            //not last question of a round
            questionIndex += 1
            return true
        }
        
    }
    
}
