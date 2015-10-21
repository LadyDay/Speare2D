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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            /*
            let boy: SKSpriteNode = self.childNodeWithName("boy") as! SKSpriteNode
            
            let currentLocation = touch.locationInNode(self)
            let pastLocation = boy.position
            let duration : NSTimeInterval = makeDuration(currentLocation, pastLocation: pastLocation)/400
            let moveToPoint = SKAction.moveTo(currentLocation, duration: duration)
            boy.runAction(moveToPoint)
            */
            let location = touch.locationInNode(self)
                for node in self.nodesAtPoint(location){
                    if(node.name == "start"){
                        animationDoor(self.childNodeWithName("leftDoor") as! SKSpriteNode, rightDoor: self.childNodeWithName("rightDoor") as! SKSpriteNode)
                        //Muda cena para StartScene
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        self.gameScene = StartScene(fileNamed: "StartScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
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
        let num1 = random()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
