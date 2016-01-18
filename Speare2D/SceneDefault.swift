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
    
    var fileName: String!
    var numberLevel: NSNumber!
    
    var offsetWalkScene: CGFloat = 15
    
    //tuto
    var clickArray = Array<SKTexture>()
    let clickAtlas = SKTextureAtlas(named: "click.atlas")
    var clickAnimation = SKAction()

    
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
    let ticketSound: String = "ticketSound.wav"
    let passosNaMadeira: String = "Passos na madeira.mp3"
    let puttingItenTuto: String = "Colocaritemnasopa.mp3"
    let fireTuto: String = "Fogueiradocaldeirao.mp3"
    let catchAnIten: String = "Pegarumitemchave.mp3"
    let dialoguePopup: String = "AparecerDialogo.mp3"
    let vaia: String = "Vaia.mp3"
    let vaia2: String = "Boo curto.wav"
    
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
            self.effectConfiguration(self.catchAnIten, waitC: true)
            gameScene.inventory.guardingObject(object as! SKSpriteNode)
            let spinAction = SKAction.rotateByAngle(CGFloat(2.0*M_PI), duration: 1)
            let goUpAction = SKAction.moveTo(CGPoint(x: object.position.x, y: 1000), duration: 1)
            let fadeAction = SKAction.fadeOutWithDuration(0.5)
            let groupActions = SKAction.group([spinAction, goUpAction, fadeAction])
            object.runAction(groupActions, completion: {object.removeFromParent()})
//            object.removeFromParent()
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
    
    
    func transitionNextScene(currentScene: SceneDefault , sceneTransition: SKScene, withTheater: Bool){
        var fadeScene = SKTransition.fadeWithDuration(1.5)
        let scene = sceneTransition as! SceneDefault
        if(withTheater){
            let gameScene = TheaterBased(fileNamed: "TheaterBased")
            let viewBased = SKView(frame: self.view!.frame)
            viewBased.backgroundColor = UIColor.clearColor()
            self.view?.addSubview(viewBased)
            gameScene?.sceneBackground = scene
            gameScene?.fileName = currentScene.fileName
            gameScene?.numberLevel = currentScene.numberLevel
            moveInfo(gameScene!)
            viewBased.presentScene(gameScene!, transition: fadeScene)
        }else{
            if(currentScene.theater != nil){
                saveCurrentScene(currentScene.theater, stringScene: currentScene.fileName)
                currentScene.theater.view?.removeFromSuperview()
                fadeScene = SKTransition.fadeWithDuration(0.1)
            }
            currentScene.moveInfo(scene)
            scene.theater = currentScene.theater
            scene.mainCharacter.offsetAlexWalk = scene.offsetWalkScene
            currentScene.view?.presentScene(scene, transition: fadeScene)
        }
    }
    
    func saveCurrentScene(gameScene: TheaterBased, stringScene: String){
        Dictionary<String, AnyObject>.saveGameData("Level" + String(gameScene.numberLevel), key: "currentScene", object: stringScene)
    }
    
    func setCamera(){
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        self.camera?.name = "camera"
    }
    
    func setPositionCamera(){
        self.camera?.position.x = 512
        self.camera?.position.y = 384
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
    
    //function for clicking hand in tutorial
    func initClickTexture(){
        clickArray.append(clickAtlas.textureNamed("clique1"))
        clickArray.append(clickAtlas.textureNamed("clique2"))
    }
    
    func initClick(clickNode: SKSpriteNode){
        clickAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(clickArray, timePerFrame: 0.3))
        //clickFadingINAnimation = SKAction.repeatActionForever(SKAction.fadeInWithDuration(1))
        //clickFadingOUTAnimation = SKAction.repeatActionForever(SKAction.fadeOutWithDuration(1))
        //let sequenceClick = SKAction.sequence([clickFadingOUTAnimation, clickFadingINAnimation])
        //let groupClick = SKAction.group([sequenceClick, clickAnimation])
        //clickNode.runAction(groupClick, withKey: "clickTutorial")
        clickNode.runAction(clickAnimation, withKey: "clickTutorial")
        
    }
    
}

