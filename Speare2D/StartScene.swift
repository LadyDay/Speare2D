//
//  StartScene.swift
//  Speare2Dtela2
//
//  Created by Alessandra Pereira on 20/10/15.
//  Copyright © 2015 Alessandra Pereira. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    var gameScene: SKScene!
    //var nodeTouched: SKNode!
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        let border = SKPhysicsBody(edgeLoopFromRect: self.frame)
        border.friction = 0.2
        
        self.physicsBody = border
        let firefox =  childNodeWithName("FirefoxNode") as! SKSpriteNode
        firefox.physicsBody?.mass = 30.0
        
        //let floor = childNodeWithName("FloorNode") as! SKSpriteNode
        
        
        
        
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touchObj = touches.first as UITouch!
        let locationTouch = touchObj.locationInNode(self)
        let firefox = childNodeWithName("FirefoxNode") as! SKSpriteNode
        let nodeTouched = nodeAtPoint(locationTouch)
        
        //Rapousa vai andar até onde tocar
        let moveFirefox = SKAction .moveToX(locationTouch.x, duration: 1.0)
        
        if nodeTouched.name == "Tutorial" {
            print("Espelho 1")
            //Rapousa anda até lá
            firefox.runAction(moveFirefox, completion: {
                //Muda cena para Opção1
                let fadeScene = SKTransition.fadeWithDuration(1.5)
                self.gameScene = TutorialScene(fileNamed: "TutorialScene")
                self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else if nodeTouched.name == "Option2"{
            print("Objeto 2")
            //Rapousa anda até lá
            firefox.runAction(moveFirefox, completion: {
                //Muda cena para Opção2
                //let fadeScene = SKTransition.fadeWithDuration(1.5)
                //self.gameScene = OptionTwo(fileNamed: "OptionTwo")
                //self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else if nodeTouched.name == "Option3"{
            print("Objeto 3")
            //Rapousa anda até lá
            firefox.runAction(moveFirefox, completion: {
                //Muda cena para Opção3
                //let fadeScene = SKTransition.fadeWithDuration(1.5)
                //self.gameScene = OptionThree(fileNamed: "OptionThree")
                //self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else {
            firefox.runAction(moveFirefox)
        }
        
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
}
