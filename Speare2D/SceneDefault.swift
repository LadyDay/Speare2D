//
//  SceneDefault.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class SceneDefault: SKScene {
    
    //inventory
    var inventory: Inventory!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    
    //mainCharacter
    var mainCharacter: Alex = Alex()
    
    //music
    var backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "backgroundMusic.mp3")
    var bgMusicVolume: Float!
    var effectsMusic: SKAudioNode = SKAudioNode(fileNamed: "effectsound.aiff")
    var effectsVolume: Float!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
//    struct Volume{
//        var bgMusicVolume: Float = 0.7
//        var effectsVolume: Float = 0.7
//        
//        init(bgMusicVolume: Float, effectsVolume: Float) {
//            self.bgMusicVolume = bgMusicVolume
//            self.effectsVolume = effectsVolume
//        }
//    }
    
    /* ANOTHER FUNCTION */
    func moveInfo(gameScene: SceneDefault){
        gameScene.mainCharacter = self.mainCharacter
        gameScene.inventory = self.inventory
        self.inventory.removeFromParent()
        self.mainCharacter.removeFromParent()
    }
    
    func musicBgConfiguration(fileString: String) {
//        let gameScene = OptionsScene(fileNamed: "OptionScene")
//        gameScene!.bgMusicVolume = self.bgMusicVolume
        backgroundMusic = SKAudioNode(fileNamed: fileString)
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        backgroundMusic.runAction(SKAction.changeVolumeTo(bgMusicVolume, duration: 0))
    
        
    }
}

