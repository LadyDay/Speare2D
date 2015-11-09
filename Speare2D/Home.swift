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

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
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

                        runAction(SKAction.playSoundFileNamed("applause.wav", waitForCompletion: false), completion:{
                            let fadeScene = SKTransition.fadeWithDuration(1.5)
                            let gameScene = StartScene(fileNamed: "StartScene")
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                        })

                        break
                    
                    case "options":
                        //chama a animação para a porta
                         backgroundMusic.removeFromParent()
                        
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
