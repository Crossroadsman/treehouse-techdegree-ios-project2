//
//  Timer.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 02/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation
//import GameKit
//import UIKit

// Timer is a class provided by apple
class TimerManager {
    
    //---debug mode---
    var timeRemaining = 2.0
    //---end debug---
    //var timeRemaining = 15.0
    var timer = Timer()
    var game: Game
    
    
    init(game: Game) {
        self.game = game
    }
    
    // Use the Timer class's scheduleTimer class method
    // to start the timer with the specified interval
    // which calls update every time the timer fires
    public func start() {
        //set up timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t: Timer) in self.update(t)})
        
    }

    
    private func update(_ timer: Timer) {
        print("updating timer")
        print("timer was: \(timeRemaining)")
        timeRemaining -= timer.timeInterval.magnitude
        print("timer now: \(timeRemaining)")
        if timeRemaining <= 0 {
            timer.invalidate()
        }
        game.timerWasUpdated()
    }
    
    
    public func getRemainingTime() -> Double {
        return timeRemaining
    }
    
    
    
}

