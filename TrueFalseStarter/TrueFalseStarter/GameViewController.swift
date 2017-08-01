//
//  GameViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // old code to remove:
    /*
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
     */
    //end old code to remove
    
    //MARK: - Properties
    //------------------
    
    //old code to remove:
    /*
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    */
    //end old code to remove

    @IBOutlet weak var lightningStackView: UIStackView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var answer1Label: UIButton!
    
    @IBOutlet weak var answer2Label: UIButton!
    
    @IBOutlet weak var answer3Label: UIButton!
    
    @IBOutlet weak var answer4Label: UIButton!
    
    
    let game = Game()
    let soundController = SoundController()
    
    //MARK: - ViewController Methods
    //-------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide lightning mode
        lightningStackView.isHidden = true
        
        /*
        for view in lightningStackView.arrangedSubviews {
            view.isHidden = true
        }
         */
        
        // Start game
        soundController.playSound(named: "start", withFileType: "mp3")
        game.start()
        displayQuestion()
    }
    
    
    //MARK: - IBActions
    //-----------------
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        let answerNumber = sender.tag
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        // If !gameOver load reload display with next question
        
        // If gameOver segue to gameOver Screen
        
    }
    
    
    //MARK: - Other Methods
    //---------------------

    
    func displayQuestion() {
        
        if game.isLightningRound() {
            lightningStackView.isHidden = false
        } else {
            lightningStackView.isHidden = true
        }
        
        questionLabel.text = game.getQuestionText()
        
//        playAgainButton.isHidden = true
    }
    
    //to delete
    /*
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
 */
    //end to delete
    
    //to delete
    /*
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
 */
    //end to delete
    
    //to delete
    /*
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
 */
    //end to delete
    
    //to delete
    /*
    @IBAction func playAgain() {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
 */
    

    
    // MARK: Helper Methods
    /*
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    */
    
}

