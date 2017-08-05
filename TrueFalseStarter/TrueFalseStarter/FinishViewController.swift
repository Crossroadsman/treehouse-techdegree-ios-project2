//
//  FinishViewController.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 31/07/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    
    var correctAnswers: Int?
    var totalQuestions: Int?

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let correctAnswers = correctAnswers, let totalQuestions = totalQuestions else {
            return
        }
        
        scoreLabel.text = "You got \(correctAnswers) right out of \(totalQuestions)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
