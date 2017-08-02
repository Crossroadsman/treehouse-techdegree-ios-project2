//
//  Round.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 01/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

enum RoundType {
    
    case normal
    case lightning
    
}

struct Round {
    
    let type: RoundType
    
    let questions: Int
    
}



