//
//  CreditosScene.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 1/21/16.
//  Copyright © 2016 LadyDay. All rights reserved.
//


import UIKit
import SpriteKit

class CreditosScene: SceneDefault {
    
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
                let location = touch.locationInNode(self)
                let nodeTouched = self.nodeAtPoint(location) as! SKSpriteNode
                let nome = nodeTouched.name!
                switch nome{
                case "background":
                    effectConfiguration(backButtonSound, waitC: true)
                    //chama a animação para a bilheteria
                    self.transitionNextScene(self, sceneTransition: InfoScene(fileNamed: "InfoScene")!, withTheater: false)
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
}

