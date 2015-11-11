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
    var cameraHome: SKCameraNode!
    var doorLeftSpriteArray = Array<SKTexture>()
    let doorLeftTextureAtlas = SKTextureAtlas(named: "portaEsquerda.atlas")
    var doorRightSpriteArray = Array<SKTexture>()
    let doorRightTextureAtlas = SKTextureAtlas(named: "portaDireita.atlas")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /* Setup your scene here */
        
        bgMusicVolume = 0.7
        effectsVolume = 0.7
        let defaultVolume = OptionsScene(fileNamed: "OptionsScene")
        defaultVolume?.bgMusicVolume = self.bgMusicVolume
        
        musicBgConfiguration("backgroundMusic.mp3")
        cameraHome = self.childNodeWithName("cameraHome") as! SKCameraNode
        
        self.initTexturesDoor()
        
        backgroundMusic = SKAudioNode(fileNamed: "backgroundMusic.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        //effectsMusic = SKAudioNode(fileNamed: "applause.wav")
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
                        self.animationDoor(self.childNodeWithName("leftDoorStart") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoorStart") as! SKSpriteNode)
                        
                        //chama a transição
                        let action1 = self.centerOnNode(self.childNodeWithName("viewStart")!)
                        let action2 = SKAction.runBlock({
                            let fadeScene = SKTransition.fadeWithDuration(1.0)
                            let gameScene = StartScene(fileNamed: "StartScene")
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))

                        break
                    
                    case "options":
                        //chama a animação para a porta
                        self.animationDoor(self.childNodeWithName("leftDoorOptions") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoorOptions") as! SKSpriteNode)
                        
                        //chama a transição
                        let action1 = self.centerOnNode(self.childNodeWithName("viewOptions")!)
                        let action2 = SKAction.runBlock({
                            let fadeScene = SKTransition.fadeWithDuration(1.0)
                            let gameScene = OptionsScene(fileNamed: "OptionsScene")
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                            self.backgroundMusic.removeFromParent()
                        })
                        cameraHome.runAction(SKAction.sequence([action1,action2]))
                        
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
    
    func animationDoor(leftDoor: SKSpriteNode, rightDoor: SKSpriteNode){
        let playerAnimationDoorLeft = SKAction.repeatAction(SKAction.animateWithTextures(doorLeftSpriteArray, timePerFrame: 0.06), count: 1)
        let playerAnimationDoorRight = SKAction.repeatAction(SKAction.animateWithTextures(doorRightSpriteArray, timePerFrame: 0.06), count: 1)
        leftDoor.runAction(playerAnimationDoorLeft)
        rightDoor.runAction(playerAnimationDoorRight)
        self.runAction(SKAction.playSoundFileNamed("applause.wav", waitForCompletion: false))
    }
    
    func initTexturesDoor(){
        for(var i = 1; i<26; i++){
            doorLeftSpriteArray.append(doorLeftTextureAtlas.textureNamed("leftDoor\(i)"))
            doorRightSpriteArray.append(doorRightTextureAtlas.textureNamed("rightDoor\(i)"))
        }
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
    
    func centerOnNode(node:SKNode) -> SKAction {
        let moveCamera = SKAction.moveTo(node.position, duration: 1.5)
        let zoomCamera = SKAction.scaleTo(0.5, duration: 1.5)
        return SKAction.group([moveCamera, zoomCamera])
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
