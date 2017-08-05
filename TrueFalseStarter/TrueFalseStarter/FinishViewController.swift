//
//  FinishViewController.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 31/07/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    //MARK: - Properties
    //------------------
    
    var correctAnswers: Int?
    var totalQuestions: Int?

    @IBOutlet weak var scoreLabel: UILabel!
    
    
    //MARK: - View Controller Methods
    //-------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let correctAnswers = correctAnswers, let totalQuestions = totalQuestions else {
            return
        }
        
        scoreLabel.text = "You got \(correctAnswers) right out of \(totalQuestions)"
    }

}
