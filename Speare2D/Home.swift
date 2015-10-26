//
//  GameScene.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 19/10/15.
//  Copyright (c) 2015 LadyDay. All rights reserved.
//
    
import SpriteKit

class Home: SKScene {
    
    var gameScene: SKScene!
    var timeLight: Int = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
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
                        //Muda cena para StartScene
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        self.gameScene = StartScene(fileNamed: "StartScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                        break
                    case "options":
                        //chama a animação para a porta
                            break
                    case "info":
                        //chama a animação para a bilheteria
                        break
                    default:
                        //emitterNode.position = location
                        break
                }
            }
        }
    }
    
    func animationDoor(leftDoor: SKSpriteNode, rightDoor: SKSpriteNode){
        
    }
    
    func makeDuration(currentLocation : CGPoint, pastLocation: CGPoint) -> NSTimeInterval{
        let catetos:CGFloat = pow(abs(currentLocation.x - pastLocation.x), 2) + pow(abs(currentLocation.y - pastLocation.y), 2)
        let hipotenusa = sqrt(catetos)

        return hipotenusa.native as NSTimeInterval //Double(hipotenusa)
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
    
    func moveBoy(touch: UITouch){
        let boy: SKSpriteNode = self.childNodeWithName("boy") as! SKSpriteNode
        let currentLocation = touch.locationInNode(self)
        let pastLocation = boy.position
        let duration : NSTimeInterval = makeDuration(currentLocation, pastLocation: pastLocation)/400
        let moveToPoint = SKAction.moveTo(currentLocation, duration: duration)
        boy.runAction(moveToPoint)
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
