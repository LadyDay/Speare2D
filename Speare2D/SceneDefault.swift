//
//  SceneDefault.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class SceneDefault: SKScene {
    
    //flag
    var touchRuning: Bool = false
    static var firstAcess: Bool = true
    
    var theater: TheaterBased!
    var givenSKView: SKView!
    
    //mainCharacter
    var mainCharacter: Alex = Alex()
    
    //music files
    let selectionButtonSound: String = "BotaoSelecionar.mp3"
    let backButtonSound: String = "Botaovoltar.mp3"
    let homeBGmusic: String = "Murmurinho teatro.mp3"
    let openingDoorEffect: String = "Porta abrindo.mp3"
    let startBGmusic: String = "SelecaoDeFases-teste.mp3"
    let transitionSound1: String = "Transicao.mp3"
    let trafficSound: String = "Transito1.mp3"
    let trafficSound2: String = "Transito2.mp3"
    let metalEffectSound: String = "effectsound.aiff"
    let applauseSound: String = "applause.wav"
    let optionsBGmusic: String = "optionsMusic.wav"
    let sliderSound: String = "slider.aiff"
    
    //Sounds
    var audioPlayer: AVAudioPlayer!
    var backgroundMusic: SKAudioNode!
    static var bgMusicVolume: Float!
    var effectsMusic: SKAudioNode!
    static var effectsVolume: Float!
    var voiceSound: SKAudioNode!
    static var voiceVolume: Float!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
    //subtitles
    static var subtitlesSwitch: Bool = true
    
    /* ANOTHER FUNCTION */
    func moveInfo(gameScene: SceneDefault){
        gameScene.mainCharacter = self.mainCharacter
        self.mainCharacter.removeFromParent()
    }
    
    //function for catch object in view
    func catchObject(gameScene: TheaterBased, location: CGPoint, object: SKNode){
        //pega qualquer objeto da tela, que seja um skspritenode sem nome
        gameScene.mainCharacter.runAction(gameScene.mainCharacter.walk(gameScene.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: object.frame.size), completion: {
            //guarding the object in the inventory
            gameScene.inventory.guardingObject(object as! SKSpriteNode)
            object.removeFromParent()
            self.touchRuning = false
        })
    }
    
    func playSoundFileNamed(fileName: NSString, atVolume: Float, waitForCompletion: Bool) -> SKAction {
        
        let nameOnly = fileName.stringByDeletingPathExtension
        let fileExt  = fileName.pathExtension
        
        let soundPath = NSBundle.mainBundle().pathForResource(nameOnly as String, ofType: fileExt as String)
        let url = NSURL.fileURLWithPath(soundPath!)
        
        
        var Aplayer:AVAudioPlayer?
        do {
            try Aplayer = AVAudioPlayer(contentsOfURL: url)
            Aplayer?.volume = atVolume
        } catch {
            print("Player not available")
        }
        
        let AplayAction: SKAction = SKAction.runBlock { () -> Void in
            Aplayer!.play()
        }
        
        if(waitForCompletion){
            let waitAction = SKAction.waitForDuration(Aplayer!.duration)
            let groupAction: SKAction = SKAction.group([AplayAction, waitAction])
            return groupAction
        }
        
        return AplayAction
    }
    
    func musicBgConfiguration(fileString: String) {
        backgroundMusic = SKAudioNode(fileNamed: fileString)
        backgroundMusic.autoplayLooped = true
        backgroundMusic.runAction(SKAction.changeVolumeTo(SceneDefault.bgMusicVolume, duration: 0))
        self.addChild(backgroundMusic)
        
    }
    
    func effectConfiguration(fileString: String, waitC: Bool){
        let effect = playSoundFileNamed(fileString, atVolume: SceneDefault.effectsVolume, waitForCompletion: true/*must be TRUE, dont know why*/)
        if (waitC == true){
            effect.duration = 10.0
            //            self.runAction(playSoundFileNamed(fileString, atVolume: SceneDefault.effectsVolume, waitForCompletion: true/*must be TRUE, dont know why*/), completion: {
            //                print("relou")
            //            })
            self.runAction(effect)
        }else{
            self.runAction(playSoundFileNamed(fileString, atVolume: SceneDefault.effectsVolume, waitForCompletion: true/*must be TRUE, dont know why*/))
        }
    }
    
    
    func transitionNextScene(sceneTransition: SceneDefault, withTheater: Bool){
        
        let fadeScene = SKTransition.fadeWithDuration(1.5)
        
        
        if(withTheater){
            let gameScene = TheaterBased(fileNamed: "TheaterBased")
            let viewBased = SKView(frame: self.view!.frame)
            viewBased.backgroundColor = UIColor.clearColor()
            self.view?.presentScene(sceneTransition)
            sceneTransition.view?.addSubview(viewBased)
            sceneTransition.theater = gameScene
            moveInfo(gameScene!)
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
    
    func setUpViews(givenSKView: SKView, /*originX: CGFloat, originY: CGFloat, sizeX: CGFloat, sizeY: CGFloat, */imageBGString: String, toBack: Bool){
        /*Setar frame da view antes de chamar essa função!!! 
        Utilizar:
        VIEW = SKView(frame: CGRectMake(originX, originY, sizeX, sizeY))*/
        self.view?.addSubview(givenSKView as UIView)
        let imageBG = UIImage(named: imageBGString)
        let imageView = UIImageView(image: imageBG)
        imageView.frame = CGRectMake(givenSKView.frame.origin.x, givenSKView.frame.origin.y, givenSKView.frame.size.width, givenSKView.frame.size.height )//(originX, originY, sizeX, sizeY)
        givenSKView.addSubview(imageView)
        if(toBack == true){
            self.givenSKView.sendSubviewToBack(imageView)
        }
    }
}

