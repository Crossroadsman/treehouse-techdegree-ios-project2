//
//  GameViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    //------------------

    @IBOutlet weak var lightningStackView: UIStackView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var game: Game!
    let soundController = SoundController()
    
    @IBOutlet weak var temp: NSLayoutConstraint!
    
    
    
    
    //MARK: - ViewController Methods
    //-------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(vc: self)
        
        // Start game
        soundController.playSound(named: "start", withFileType: "wav")
        game.start()
        
        displayQuestion()
        
    }
    
    
    //MARK: - IBActions
    //-----------------
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        //let answerNumber = sender.tag
        
        let buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
        
        // color the sender orange
        // (only appears if the answer is wrong)
        sender.setTitleColor(Color.orange, for: .normal)
        
        for button in buttons {

            // color the correct answer green
            if game.isCorrect(answer: button!.titleLabel!.text!) {
                button?.setTitleColor(Color.green, for: .normal)
            }
            
            //disable button
            button!.isEnabled = false
        }
        
        game.answerQuestion(answer: sender.titleLabel!.text!)
        
        if game.isCorrect(answer: sender.titleLabel!.text!) {
            
            soundController.playSound(named: "correct", withFileType: "wav")
            
            print("correct")
            resultLabel.text = "That's Correct!"
            resultLabel.textColor = Color.green
            resultLabel.isHidden = false

        } else {
            
            soundController.playSound(named: "incorrect", withFileType: "wav")
            
            resultLabel.text = "Sorry, that's not it."
            resultLabel.textColor = Color.orange
            resultLabel.isHidden = false
        }
        
        //enable nextButton
        
        nextQuestionButton.isHidden = false
        nextQuestionButton.isEnabled = true
       
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        let isNextRound = game.isNextRound()
        
        if isNextRound {
            // If !gameOver load reload display with next question
            
            nextQuestionButton.isEnabled = false
            nextQuestionButton.isHidden = true
            
            displayQuestion()
        } else {
            // If gameOver segue to gameOver Screen
            performSegue(withIdentifier: "toFinishViewController", sender: nil)
        }
        
        
    }
    
    
    //MARK: - Other Methods
    //---------------------

    
    func displayQuestion() {

        let answers = game.getAnswers()

        
        // hide result label
        resultLabel.isHidden = true
        
        // check if lightning, if so, show lightning specific UI
        if game.isLightningRound() {
            showLightning()
        } else {
            hideLightning()
        }
        
        let buttons: [UIButton]
        
        switch answers.count {
        case 3:
            buttons = [answer1Button, answer2Button, answer3Button]
            answer4Button.isHidden = true
        case 4:
            answer4Button.isHidden = false
            buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
        default:
            fatalError("Unsupported number of answers")
        }

        // enable buttons
        for (index, button) in buttons.enumerated() {
            
            button.isEnabled = true
            button.setTitle(answers[index], for: .normal)
            button.setTitleColor(Color.lightGrey, for: .normal)

        }
        
        

        
        // set labels
        questionLabel.text = game.getQuestionText()
        
        
//         playAgainButton.isHidden = true
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
    
    func hideLightning() {
        for view in lightningStackView.arrangedSubviews {
            if view.tag == 100 {
                view.isHidden = true
            }
        }
    }
    
    func showLightning() {
        for view in lightningStackView.arrangedSubviews {
            if view.tag == 100 {
                view.isHidden = false
            }
        }
    }
    
    func updateTimeRemaining() {
        timeRemainingLabel.text = "⏱\(game.lightningTimeRemaining()!)"
    }
    
}

