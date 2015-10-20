//
//  GameScene.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 19/10/15.
//  Copyright (c) 2015 LadyDay. All rights reserved.
//

import SpriteKit

class Home: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let boy: SKSpriteNode = self.childNodeWithName("boy") as! SKSpriteNode
            
            let location = touch.locationInNode(self)
            let duration : NSTimeInterval = makeDuration(location)
            let moveToPoint = SKAction.moveTo(location, duration: duration)
            boy.runAction(moveToPoint)
        }
    }
    
    func makeDuration(location : CGPoint) -> NSTimeInterval{
        let catetos = pow(location.x, 2) + pow(location.y, 2)
        let hipotenusa = pow(catetos, 1/2) //sqrt(catetos)

        return Double(hipotenusa)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
