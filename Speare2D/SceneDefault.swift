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
    
//    //optionView
//    var optionView: SKView!
//    
//    func setUpOptionView(view: SceneDefault){
//        view.optionView = SKView(frame: CGRectMake(0, 0, 1024, 768))
//        view.optionView.backgroundColor = UIColor.clearColor()
//        view.view?.addSubview(optionView as UIView)
//        //view = self.optionView
//    }

    
    //music files
    let selectionButtonSound: String = "BotaoSelecionar.mp3"
    let backButtonSound: String = "Botaoboltar.mp3"
    let homeBGmusic: String = "Murmurinho teatro.mp3"
    let openingDoorEffect: String = "Porta abrindo.mp3"
    let startBGmusic: String = "Seleção de fases - teste.mp3"
    let transitionSound1: String = "Transicao.mp3"
    let trafficSound: String = "Transito1.mp3"
    let trafficSound2: String = "Transito2.mp3"
    let metalEffectSound: String = "effectsound.aiff"
    let applauseSound: String = "applause.wav"
    
    //music
    var backgroundMusic: SKAudioNode!
    var bgMusicVolume: Float!
    var effectsMusic: SKAudioNode!
    var effectsVolume: Float!
    var voiceSound: SKAudioNode!
    var voiceVolume: Float!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
    func musicBgConfiguration(fileString: String) {
        //        let gameScene = OptionsScene(fileNamed: "OptionScene")
        //        gameScene!.bgMusicVolume = self.bgMusicVolume
        backgroundMusic = SKAudioNode(fileNamed: fileString)
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        backgroundMusic.runAction(SKAction.changeVolumeTo(self.bgMusicVolume, duration: 0))
        
        
    }
    
    /* ANOTHER FUNCTION */
    func moveInfo(gameScene: SceneDefault){
        gameScene.mainCharacter = self.mainCharacter
        gameScene.inventory = self.inventory
        self.inventory.removeFromParent()
        self.mainCharacter.removeFromParent()
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

