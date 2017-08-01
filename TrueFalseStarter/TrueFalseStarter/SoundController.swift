//
//  SoundController.swift
//  TrueFalseStarter
//
//  Created by Alex Koumparos on 01/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit
import AudioToolbox

class SoundController: NSObject {
    
    private var gameSound: SystemSoundID = 0
    
    private func loadSound(named name: String, withFileType fileType: String) {
        
        let pathtoSoundFile = Bundle.main.path(forResource: name, ofType: fileType)
        let soundUrl = URL(fileURLWithPath: pathtoSoundFile!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        
    }
    
    private func playSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    public func playSound(named name: String, withFileType fileType: String) {
        loadSound(named: name, withFileType: fileType)
        playSound()
    }

}
