//
//  StartScene.swift
//  Speare2Dtela2
//
//  Created by Alessandra Pereira on 20/10/15.
//  Copyright © 2015 Alessandra Pereira. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SceneDefault {
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        mainCharacter.setupAlex()
        addChild(mainCharacter)
        
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
    }
    
    /* Called when a touch begins */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
        if let touch = touches.first{
            var location = touch.locationInNode(self)
            for nodeTouched in self.nodesAtPoint(location){
                guard let nome = nodeTouched.name else {continue ;}
                switch nome{
                case "tutorial":
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, objectPresent: false, objectSize: nil), completion: {
                        //Muda cena para Opção1
                        self.touchRuning = false
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        let gameScene = TutorialScene(fileNamed: "TutorialScene")
                        gameScene!.mainCharacter = self.mainCharacter
                        self.mainCharacter.removeFromParent()
                        self.view?.presentScene(gameScene!, transition: fadeScene)
                    })
                    break
                    
                case "exitNode":
                    //chama a animação para a bilheteria
                    location = CGPoint(x: -70, y: 300)
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), objectPresent: false, objectSize: nil), completion: {
                        //Volta ao menu
                        self.touchRuning = false
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        let gameScene = Home(fileNamed: "Home")
                        self.view?.presentScene(gameScene!, transition: fadeScene)
                    })
                    break
                    
                default:
                    if location.y<200 {
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                        })
                    }else{
                        self.touchRuning = false
                    }
                    break
                }
            }
        }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
        if mainCharacter.position.x < 476.0 {
            self.camera?.position = CGPoint(x: 476, y: 387.942)
        } else if mainCharacter.position.x > 545.0 {
            self.camera?.position = CGPoint(x: 545.0, y: 387.942)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 387.942)
        }
        
    }
    
}
