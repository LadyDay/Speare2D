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
    var locationTouch: CGPoint!
    var mainCharacter: SKNode!
    //var camera: SKNode!
    //var nodeTouched: SKNode!
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        //let border = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //border.friction = 0.2
        
        //self.physicsBody = border
        mainCharacter =  childNodeWithName("FirefoxNode") as! SKSpriteNode
        mainCharacter.physicsBody?.mass = 30.0
        
        //let floor = childNodeWithName("FloorNode") as! SKSpriteNode
        //camera = childNodeWithName("CameraNode")
        
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touchObj = touches.first as UITouch!
        locationTouch = touchObj.locationInNode(self)
        //let firefox = childNodeWithName("FirefoxNode") as! SKSpriteNode
        let nodeTouched = nodeAtPoint(locationTouch)
        
        //Rapousa vai andar até onde tocar
        let moveMainCharacter = SKAction .moveToX(locationTouch.x, duration: 1.0)
        
        if nodeTouched.name == "Tutorial" {
            print("Espelho 1")
            //Rapousa anda até lá
            mainCharacter.runAction(moveMainCharacter, completion: {
                //Muda cena para Opção1
                let fadeScene = SKTransition.fadeWithDuration(1.5)
                self.gameScene = TutorialScene(fileNamed: "TutorialScene")
                self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else if nodeTouched.name == "Option2"{
            print("Objeto 2")
            //Rapousa anda até lá
            mainCharacter.runAction(moveMainCharacter, completion: {
                //Muda cena para Opção2
                //let fadeScene = SKTransition.fadeWithDuration(1.5)
                //self.gameScene = OptionTwo(fileNamed: "OptionTwo")
                //self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else if nodeTouched.name == "Option3"{
            print("Objeto 3")
            //Rapousa anda até lá
            mainCharacter.runAction(moveMainCharacter, completion: {
                //Muda cena para Opção3
                //let fadeScene = SKTransition.fadeWithDuration(1.5)
                //self.gameScene = OptionThree(fileNamed: "OptionThree")
                //self.view?.presentScene(self.gameScene!, transition: fadeScene)
            })
        } else {
            mainCharacter.runAction(moveMainCharacter)
        }
        
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
        if mainCharacter.position.x < 40.0 {
            self.camera?.position = CGPoint(x: 40, y: 387.942)
        } else if mainCharacter.position.x > 1080.0 {
            self.camera?.position = CGPoint(x: 1080.0, y: 387.942)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 387.942)
        }
        
    }
    
    override func didSimulatePhysics() {
        //<#code#>
    }
    
    
}
