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
    static var firstAcess: Bool = true
    
    var theater: TheaterBased?
    
    //inventory
    var inventory: Inventory = Inventory(fileNamed: "Inventory")!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    
    //mainCharacter
    var mainCharacter: Alex = Alex()
    
    //music files
    let selectionButtonSound: String = "BotaoSelecionar.mp3"
    let backButtonSound: String = "Botaoboltar.mp3"
    let homeBGmusic: String = "Murmurinho teatro.mp3"
    let openingDoorEffect: String = "Porta abrindo.mp3"
    let startBGmusic: String = "SelecaoDeFases-teste.mp3"
    let transitionSound1: String = "Transicao.mp3"
    let trafficSound: String = "Transito1.mp3"
    let trafficSound2: String = "Transito2.mp3"
    let metalEffectSound: String = "effectsound.aiff"
    let applauseSound: String = "applause.wav"
    
    //music
    var backgroundMusic: SKAudioNode!
    static var bgMusicVolume: Float!
    var effectsMusic: SKAudioNode!
    static var effectsVolume: Float!
    var voiceSound: SKAudioNode!
    static var voiceVolume: Float!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
    /* ANOTHER FUNCTION */
    func moveInfo(gameScene: SceneDefault){
        gameScene.mainCharacter = self.mainCharacter
        self.mainCharacter.removeFromParent()
    }
    

    func musicBgConfiguration(fileString: String) {
        backgroundMusic = SKAudioNode(fileNamed: fileString)
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        backgroundMusic.runAction(SKAction.changeVolumeTo(SceneDefault.bgMusicVolume, duration: 0))

        
    }
    
    func transitionNextScene(sceneTransition: SceneDefault, withTheater: Bool){
        
        let fadeScene = SKTransition.fadeWithDuration(1.5)
        
        
        if(withTheater){
            let gameScene = TheaterBased(fileNamed: "TheaterBased")
            let viewBased = SKView(frame: CGRectMake(0, 0, 1024, 768))
            viewBased.backgroundColor = UIColor.clearColor()
            moveInfo(sceneTransition)
            self.view?.presentScene(sceneTransition)
            sceneTransition.view?.addSubview(viewBased)
            self.theater = gameScene
            viewBased.presentScene(gameScene)
            
        }else{
            moveInfo(sceneTransition)
            self.view?.presentScene(sceneTransition, transition: fadeScene)
        }
    }
    
    func setCamera(){
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
    }
    
    func updateCameraTheater(object: SKSpriteNode){
        if object.position.x < 512 {
            //self.camera?.position = CGPoint(x: 512, y: 384)
            self.camera?.runAction(SKAction.moveTo(CGPoint(x: 512, y: 384), duration: 1))
        } else if object.position.x > 1536 {
            //self.camera?.position = CGPoint(x: 1536, y: 384)
            self.camera?.runAction(SKAction.moveTo(CGPoint(x: 1536, y: 384), duration: 1))
        } else {
            //self.camera?.position = CGPoint(x: object.position.x, y: 384)
            self.camera?.runAction(SKAction.moveTo(CGPoint(x: object.position.x, y: 384), duration: 1))
        }
    }
    
    func updateCameraSceneDefault(){
        if mainCharacter.position.x < 512 {
            self.camera?.position = CGPoint(x: 512, y: 384)
        } else if mainCharacter.position.x > 1536 {
            self.camera?.position = CGPoint(x: 1536, y: 384)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 384)
        }
    }
}

