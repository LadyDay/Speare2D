//
//  GameScene.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 19/10/15.
//  Copyright (c) 2015 LadyDay. All rights reserved.
//
    
import SpriteKit

class Home: SceneDefault {
    
    var timeLight: Int = 0
    var doorLeftSpriteArray = Array<SKTexture>()
    let doorLeftTextureAtlas = SKTextureAtlas(named: "DoorOpened.atlas")
    var doorRightSpriteArray = Array<SKTexture>()
    let doorRightTextureAtlas = SKTextureAtlas(named: "DoorOpened.atlas")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.initTexturesDoor()
        
        backgroundMusic = SKAudioNode(fileNamed: "backgroundMusic.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        applauseEffect = SKAudioNode(fileNamed: "applause.wav")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            //let emitterNode = childNodeWithName("EmitterNode1") as! SKEmitterNode
            let location = touch.locationInNode(self)
            for node in self.nodesAtPoint(location){
                switch node.name!{
                    case "start":
                        //chama a animação para a porta
                        self.animationDoor(self.childNodeWithName("leftDoorStart") as! SKSpriteNode)
                        //chama o zoom de tela
                        runAction(SKAction.playSoundFileNamed("applause.wav", waitForCompletion: true), completion:{
                            //chama a transição de cena
                            let fadeScene = SKTransition.fadeWithDuration(1.5)
                            let gameScene = StartScene(fileNamed: "StartScene")
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                        })
                        break
                    
                    case "options":
                        //chama a animação para a porta
                        self.animationDoor(self.childNodeWithName("leftDoorOptions") as! SKSpriteNode)
                        runAction(SKAction.playSoundFileNamed("applause.wav", waitForCompletion: true), completion:{
                            self.backgroundMusic.removeFromParent()
                        })
                        break
                    
                    case "info":
                        //chama a animação para a bilheteria
                        break
                    
                    default:
                        break
                }
            }
        }
    }
    
    func animationDoor(leftDoor: SKSpriteNode){

        let playerAnimationDoorLeft = SKAction.repeatAction(SKAction.animateWithTextures(doorLeftSpriteArray, timePerFrame: 0.1), count: 1)
        //let playerAnimationDoorRight = SKAction.repeatAction(SKAction.animateWithTextures(waitingDoorLeftSpriteArray, timePerFrame: 0.2), count: 1)
        leftDoor.runAction(playerAnimationDoorLeft)
    }
    
    func initTexturesDoor(){
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-01"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-02"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-03"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-04"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-05"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-06"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-07"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-08"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-09"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-10"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-11"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-12"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-13"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-14"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-15"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-16"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-17"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-18"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-19"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-20"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-21"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-22"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-23"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-24"))
        doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("sprites-25"))
    }
    
    func turnOnLights(){
        let num = arc4random_uniform(3)
        print("\(num)")
        
        for(var i = 0; i<15; i++){
            let light = self.childNodeWithName("light\(i)") as! SKLightNode
            light.enabled = false
        }
        
        for(var i = num; i<15; i = i + 3){
            let light = self.childNodeWithName("light\(i)") as! SKLightNode
            light.enabled = true
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(self.timeLight==3){
            self.turnOnLights()
            self.timeLight = 0
        }else{
            self.timeLight = self.timeLight+1
        }
        
    }
}
