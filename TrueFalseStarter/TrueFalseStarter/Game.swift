//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 01/08/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Game {
    
    // Associated value is number of questions in round
    enum Round {
        case normal(Int)
        case lightning(Int)
    }
    
    let rounds: [Round] = [.normal(4), .lightning(4)]
    
    
}
