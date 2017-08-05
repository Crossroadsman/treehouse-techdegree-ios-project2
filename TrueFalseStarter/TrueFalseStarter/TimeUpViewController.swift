//
//  TimeUpViewController.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 04/08/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class TimeUpViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToGameViewController", sender: nil)
    }
    
    
}
