//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 01/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
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
    
    private var currentRoundIndex = 0
    
    private var questionInRound = 0
    
    private var timerManager: TimerManager?
    
    private var vc: GameViewController!

    private var gameOver: Bool = false
    
    
    //MARK: - Initializers
    //--------------------
    
    init(vc: GameViewController) {
        
        // check that we have enough questions, else crash
        // (since there is no right way for the app to behave
        // if we insist on n unique questions, but fewer than n unique
        // questions exist, a crash is the only appropriate response
        guard let bank = getQuestions(number: rounds.reduce(0, {$0 + $1.questions}), fromBanks: [mainQuestionBank]) else {
            fatalError("Requested more questions than available")
        }
        questionBank = bank
        
        
        self.vc = vc
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
            let tempArray = randomSource.arrayByShufflingObjects(in: flatBank) as! [Question]
            return Array(tempArray.prefix(upTo: number))
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
        currentRoundIndex = 0
        questionInRound = 0
        gameOver = false
    }
    
    public func getQuestionText() -> String {
        return questionBank[questionIndex].question
    }
    
    public func getAnswers() -> [String] {
        return questionBank[questionIndex].getAnswers()
    }
    
    public func isLightningRound() -> Bool {
        return rounds[currentRoundIndex].type == .lightning
    }
    
    public func lightningTimeRemaining() -> Int? {
        
        if let manager = timerManager {
            return Int( manager.getRemainingTime() )
        }
        
        return nil
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
        
        print("just completed question with index \(questionIndex)")
        print("(round index: \(currentRoundIndex), question index in round: \(questionInRound))")
        print("total rounds in game: \(rounds.count)")
        print("total questions in game: \(questionBank.count)")
        print("total questions in current round: \(rounds[currentRoundIndex].questions)")
        
        let timeLeft: Bool
        if let manager = timerManager {
            timeLeft = manager.getRemainingTime() > 0
        } else {
            timeLeft = true
        }
        
        switch (timeLeft, questionIndex) {
        case (false, _):
            print("checking if there is a next round. No time left, therefore no next round")
            gameOver = true
            return false
        case (_, _) where (questionIndex >= questionBank.count - 1):
            // just completed last question of last round
            gameOver = true
            return false
            
        case (_, _) where (questionInRound >= rounds[currentRoundIndex].questions - 1):
            // just completed last question of round other than last round
            questionIndex += 1
            currentRoundIndex += 1
            if isLightningRound() {
                startLightning()
            }
            questionInRound = 0
            return true
            
        default:
            //not last question of a round
            questionIndex += 1
            questionInRound += 1
            return true
        }
        
    }
    
    /**
     Activate the timer
    */
    private func startLightning() {
        timerManager = TimerManager(game: self)
        print("starting timer")
        timerManager!.start()
    }
    
    /**
     Lets the Timer notify the Game that the timer was updated
    */
    public func timerWasUpdated() {
        updateControllerTime()
    }
    
    /**
     Lets the game notify the view controller that the timer
     was updated
     */
    public func updateControllerTime() {
        vc.updateTimeRemaining()
    }
    
    /**
     returns a tuple containing the score and number of questions
     */
    public func getScore() -> (Int, Int) {
        return (score, questionIndex + 1)
    }
    
    public func isGameOver() -> Bool {
        return gameOver
    }
    
}
