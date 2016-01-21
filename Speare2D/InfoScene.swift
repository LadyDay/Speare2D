//
//  InfoScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 25/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class InfoScene: SceneDefault {
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        self.userInteractionEnabled = true
        mainCharacter.setupAlex()
        mainCharacter.name = "Alex"
        addChild(mainCharacter)
        setCamera()
        setPositionCamera()
        musicBgConfiguration(startBGmusic)
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
            if let touch = touches.first{
                var location = touch.locationInNode(self)
                let nodeTouched = self.nodeAtPoint(location) as! SKSpriteNode
                let nome = nodeTouched.name!
                switch nome{
                case "exitNode":
                    effectConfiguration(backButtonSound, waitC: true)
                    //chama a animação para a bilheteria
                    location = CGPoint(x: -70, y: 300)
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                        //Volta ao menu
                        self.transitionNextScene(self, sceneTransition: Home(fileNamed: "Home")!, withTheater: false)
                    })
                    break
                    
                case "introdution":
                    effectConfiguration(backButtonSound, waitC: true)
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                        self.transitionNextScene(self, sceneTransition: Introdution(fileNamed: "Introdution")!, withTheater: false)
                    })
                    break
                    
                case "creditos":
                    effectConfiguration(backButtonSound, waitC: true)
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                        self.transitionNextScene(self, sceneTransition: CreditosScene(fileNamed: "CreditosScene")!, withTheater: false)
                    })
                    self.touchRuning = false
                    break
                    
                default:
                    if location.y<200 {
                        if(location.x>950){
                            mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: CGPoint(x: 950, y: touch.locationInNode(self).y), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                self.touchRuning = false
                            })
                        }else{
                            mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                self.touchRuning = false
                            })
                        }
                    }else{
                        self.touchRuning = false
                    }
                    break
                }
            }
        }
    }

    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
}
