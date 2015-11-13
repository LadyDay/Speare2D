//
//  SceneDefault.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class SceneDefault: SKScene {
    
    //flag
    var touchRuning: Bool = false
    var firstAcess: Bool = true
    
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
    var voiceSound: SKAudioNode = SKAudioNode(fileNamed: "effectsound.aiff")
    var voiceVolume: Float!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
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
        backgroundMusic.runAction(SKAction.changeVolumeTo(self.bgMusicVolume, duration: 0))
        
        
    }
    
    func setCamera(){
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
    }
    
    func updateCamera(){
        if mainCharacter.position.x < 512 {
            self.camera?.position = CGPoint(x: 512, y: 384)
        } else if mainCharacter.position.x > 1536 {
            self.camera?.position = CGPoint(x: 1536, y: 384)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 384)
        }
    }
}

