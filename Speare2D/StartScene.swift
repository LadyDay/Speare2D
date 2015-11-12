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
        setCamera()
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
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
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
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                        //Volta ao menu
                        self.touchRuning = false
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        let gameScene = Home(fileNamed: "Home")
                        self.view?.presentScene(gameScene!, transition: fadeScene)
                    })
                    break
                    
                default:
                    if location.y<200 {
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
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
        updateCamera()
    }
    
}
