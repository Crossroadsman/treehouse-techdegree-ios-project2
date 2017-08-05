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
    
    @IBOutlet weak var temp: NSLayoutConstraint!
    
    var game: Game!
    let soundController = SoundController()
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        if game.isGameOver() {
            performSegue(withIdentifier: "toFinishViewController", sender: self)
        }
    }

    
    //MARK: - Navigation
    //------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue")
        if let segueId = segue.identifier {
            
            switch segueId {
                
            case "toTimeUpViewController":
                let destinationVC = segue.destination as! TimeUpViewController
                
                destinationVC.isNextRound = game.isNextRound()
                
            case "toFinishViewController":
                print("going to finish view controller")
                let destinationVC = segue.destination as! FinishViewController
                
                let (score, questions) = game.getScore()
                destinationVC.correctAnswers = score
                destinationVC.totalQuestions = questions
                game.start() // clear game state to enable finishviewcontroller to unwind **through** gameviewcontroller to startviewcontroller without getting interrupted by the gameovercheck in gameviewcontroller 
            default:
                print("No segue ID")
                return
            }
            
        }
     
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
    
    @IBAction func nextButtonTapped(_ sender: UIButton?) {
        print("next button tapped")
        let isNextRound = game.isNextRound()
        
        if isNextRound {
            // If !gameOver load reload display with next question
            
            nextQuestionButton.isEnabled = false
            nextQuestionButton.isHidden = true
            
            displayQuestion()
        } else {
            // If gameOver segue to gameOver Screen
            performSegue(withIdentifier: "toFinishViewController", sender: self)
        }
        
        
    }
    
    
    @IBAction func unwindToGameViewController(segue: UIStoryboardSegue) {
        print("unwind segue called")
        
        print("segueing out to finish view controller")
        
    }

    
    //MARK: - Other Methods
    //---------------------

    
    /**
     Get question details from game and populate UI elements
     */
    private func displayQuestion() {

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
    }
    
    
    /**
     Get ready to transition to time up
     */
    private func segueToTimeUp() {
        let _ = game.isNextRound()

        performSegue(withIdentifier: "toTimeUpViewController", sender: self)
    }
    
    /**
     Update visual elements for coming out of lightning mode
     */
    private func hideLightning() {
        for view in lightningStackView.arrangedSubviews {
            if view.tag == 100 {
                view.isHidden = true
            }
        }
    }
    
    /**
     Update visual elements for going into lightning mode
     */
    private func showLightning() {
        for view in lightningStackView.arrangedSubviews {
            if view.tag == 100 {
                view.isHidden = false
            }
        }
    }
    
    /**
     Update timer display (called by Game)
     */
    public func updateTimeRemaining() {
        
        guard let timeRemaining = game.lightningTimeRemaining() else {
            return
        }
        
        timeRemainingLabel.text = "⏱\(timeRemaining)"
        
        if timeRemaining <= 0 {
            segueToTimeUp()
        }
        

    }
    
}

