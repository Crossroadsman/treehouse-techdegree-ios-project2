//
//  TimeUpViewController.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 04/08/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.
//

import UIKit

class TimeUpViewController: UIViewController {
    
    
    var isNextRound: Bool?

    
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        guard let isNextRound = isNextRound else {
            return
        }
        
        if isNextRound {
            continueButton.setTitle("Continue", for: .normal)
        } else {
            continueButton.setTitle("Game Over", for: .normal)
        }
        
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        print("about to perform segue")
        performSegue(withIdentifier: "unwindToGameViewController", sender: nil)
    }
    
}
