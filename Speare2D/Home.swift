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

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /* Setup your scene here */
        countDoorAnimation = 0

        if(self.firstAcess){
            self.bgMusicVolume = 0.7
            self.effectsVolume = 0.7
            self.voiceVolume = 0.7
        }
        self.firstAcess = false
        print("volume bg: \(self.bgMusicVolume)")
        musicBgConfiguration(homeBGmusic)
        
        
        cameraHome = self.childNodeWithName("cameraHome") as! SKCameraNode
        
        self.initTexturesDoor()
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
                            self.touchRuning = false
                            self.transitionNextScene(StartScene(fileNamed: "StartScene")!, withTheater: false)
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
                            self.transitionNextScene(OptionsScene(fileNamed: "OptionsScene")!, withTheater: false)

                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))
                        
                        break
                    
                    case "info":
                        //chama a animação para a bilheteria
                        self.touchRuning = false
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
        self.runAction(SKAction.playSoundFileNamed(openingDoorEffect, waitForCompletion: false))
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
        let moveCamera = SKAction.moveTo(node.position, duration: 1.5)
        let zoomCamera = SKAction.scaleTo(0.5, duration: 1.5)
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
