//
//  GameScene.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 19/10/15.
//  Copyright (c) 2015 LadyDay. All rights reserved.
//

import SpriteKit

class Home: SceneDefault {
    
    var countDoorAnimation: Int = 0
    var cameraHome: SKCameraNode!
    var doorLeftSpriteArray = Array<SKTexture>()
    var doorHalfLeftSpriteArray = Array<SKTexture>()
    let doorLeftTextureAtlas = SKTextureAtlas(named: "portaEsquerda.atlas")
    var doorRightSpriteArray = Array<SKTexture>()
    var doorHalfRightSpriteArray = Array<SKTexture>()
    let doorRightTextureAtlas = SKTextureAtlas(named: "portaDireita.atlas")
    
    let backTextureAtlas = SKTextureAtlas(named: "menuScene.atlas")
    var backSpriteArray = Array<SKTexture>()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /* Setup your scene here */
        let background = self.childNodeWithName("background") as! SKSpriteNode
        self.initSpriteArray()
        let action = SKAction.animateWithTextures(backSpriteArray, timePerFrame: 0.5)
        background.runAction(SKAction.repeatActionForever(action))
        
        countDoorAnimation = 0
        
        if(SceneDefault.firstAcess){
            SceneDefault.bgMusicVolume = 0.7
            SceneDefault.effectsVolume = 0.7
            SceneDefault.voiceVolume = 0.7
            SceneDefault.firstAcess = false
        }
        musicBgConfiguration(homeBGmusic)
        
        
        cameraHome = self.childNodeWithName("cameraHome") as! SKCameraNode
        
        self.initTexturesDoor()
    }
    
    func initSpriteArray(){
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite1"))
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite2"))
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite3"))
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite4"))
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite5"))
        backSpriteArray.append(backTextureAtlas.textureNamed("menuSprite6"))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(!self.touchRuning){
            self.touchRuning = true
            if let touch = touches.first {
                //let emitterNode = childNodeWithName("EmitterNode1") as! SKEmitterNode
                let location = touch.locationInNode(self)
                //for node in self.nodesAtPoint(location){
                if let node: SKNode = self.nodeAtPoint(location){
                    switch node.name!{
                    case "start":
                        //chama a animação para a porta
                        self.animationDoor(self.childNodeWithName("leftDoorStart") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoorStart") as! SKSpriteNode)
                        
                        //chama a transição
                        let action1 = self.centerOnNode(self.childNodeWithName("viewStart")!)
                        let action2 = SKAction.runBlock({
                            if let dictionaryTutorial = Dictionary<String, AnyObject>.loadGameData("Tutorial"){
                                let info = dictionaryTutorial["introdutionPresent"] as! Bool
                                if(!info){
                                    self.touchRuning = false
                                    self.transitionNextScene(self, sceneTransition: Introdution(fileNamed: "Introdution")!, withTheater: false)
                                }else{
                                    self.touchRuning = false
                                    self.transitionNextScene(self, sceneTransition: StartScene(fileNamed: "StartScene")!, withTheater: false)
                                }
                            }
                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))
                        
                        break
                        
                    case "options":
                        //chama a animação para a porta
                        self.animationDoor(self.childNodeWithName("leftDoorOptions") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoorOptions") as! SKSpriteNode)
                        
                        //chama a transição
                        let action1 = self.centerOnNode(self.childNodeWithName("viewOptions")!)
                        let action2 = SKAction.runBlock({
                            self.touchRuning = false
                            self.transitionNextScene(self, sceneTransition: OptionsScene(fileNamed: "OptionsScene")!, withTheater: false)
                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))
                        
                        break
                        
                    case "info":
                        //chama a animação para a bilheteria
                        effectConfiguration(ticketSound, waitC: true)
                        let action1 = self.centerOnNode(self.childNodeWithName("viewInfo")!)
                        let action2 = SKAction.runBlock({
                            self.touchRuning = false
                            self.transitionNextScene(self, sceneTransition: InfoScene(fileNamed: "InfoScene")!, withTheater: false)
                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))

                        break
                        
                    default:
                        self.touchRuning = false
                        break
                    }
                }
            }
        }
    }
    
    func animationDoor(leftDoor: SKSpriteNode, rightDoor: SKSpriteNode){
        let playerAnimationDoorLeft = SKAction.repeatAction(SKAction.animateWithTextures(doorLeftSpriteArray, timePerFrame: 0.06), count: 1)
        let playerAnimationDoorRight = SKAction.repeatAction(SKAction.animateWithTextures(doorRightSpriteArray, timePerFrame: 0.06), count: 1)
        leftDoor.runAction(playerAnimationDoorLeft)
        rightDoor.runAction(playerAnimationDoorRight)
        //self.runAction(SKAction.playSoundFileNamed(openingDoorEffect, waitForCompletion: false))
        effectConfiguration(openingDoorEffect, waitC: false)
    }
    
    func animationHalfDoor(leftDoor: SKSpriteNode, rightDoor: SKSpriteNode){
        let playerAnimationDoorLeft = SKAction.repeatAction(SKAction.animateWithTextures(doorHalfLeftSpriteArray, timePerFrame: 0.08), count: 1)
        let playerAnimationDoorRight = SKAction.repeatAction(SKAction.animateWithTextures(doorHalfRightSpriteArray, timePerFrame: 0.08), count: 1)
        leftDoor.runAction(playerAnimationDoorLeft)
        rightDoor.runAction(playerAnimationDoorRight)
    }
    
    func initTexturesDoor(){
        for(var i = 1; i<26; i++){
            doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("leftDoor\(i)"))
            doorRightSpriteArray.append(doorRightTextureAtlas.textureNamed("rightDoor\(i)"))
        }
        
        for(var i = 1; i<7; i++){
            doorHalfLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("leftDoor\(i)"))
            doorHalfRightSpriteArray.append(doorRightTextureAtlas.textureNamed("rightDoor\(i)"))
        }
        
        for(var i = 6; i>0; i--){
            doorHalfLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("leftDoor\(i)"))
            doorHalfRightSpriteArray.append(doorRightTextureAtlas.textureNamed("rightDoor\(i)"))
        }
    }
    
    
    func centerOnNode(node:SKNode) -> SKAction {
        var position : CGPoint = node.position
        //if(position.y/2 < 384){
        //    position.y = 384
        //}
        let moveCamera = SKAction.moveTo(position, duration: 2.5)
        let zoomCamera = SKAction.scaleTo(0.25, duration: 2.5)
        return SKAction.group([moveCamera, zoomCamera])
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(countDoorAnimation==300){
            countDoorAnimation = 0
            if(!touchRuning){
                animationHalfDoor(self.childNodeWithName("leftDoorStart") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoorStart") as! SKSpriteNode)
            }
        }else{
            countDoorAnimation++
        }
    }
}
