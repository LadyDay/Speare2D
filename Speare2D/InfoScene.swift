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
    var countTicketAnimation: Int = 0
    var ticketTurn: Bool = true

    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        musicBgConfiguration(optionsBGmusic)
        countTicketAnimation = 0
        ticketTurn = true
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
            if let touch = touches.first{
                var location = touch.locationInNode(self)
                for nodeTouched in self.nodesAtPoint(location){
                    guard let nome = nodeTouched.name else {continue ;}
                    switch nome{
                    case "introButton":
                        effectConfiguration(selectionButtonSound, waitC: true)
                        self.transitionNextScene(self, sceneTransition: Introdution(fileNamed: "Introdution")!, withTheater: false)
                        break
                        
                    case "ticketBackButton":
                        effectConfiguration(backButtonSound, waitC: true)
                        self.transitionNextScene(self, sceneTransition: Home(fileNamed: "Home")!, withTheater: false)
                        break
                        
                    case "teamButton":
                        effectConfiguration(selectionButtonSound, waitC: true)
                        //self.transitionNextScene(TeamScene(fileNamed: "TeamScene")!, withTheater: false)
                        break
                        
                    default:
                        self.touchRuning = false
                        break
                    }
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(countTicketAnimation==300){
            countTicketAnimation = 0
            ticketTurn = !ticketTurn
            if(!touchRuning){
                if(ticketTurn){
                   animationTicket(self.childNodeWithName("introButton") as! SKSpriteNode)
                } else {
                    animationTicket(self.childNodeWithName("teamButton") as! SKSpriteNode)
                }
            }
        }else{
            countTicketAnimation++
        }
    }
    
    func animationTicket(Object: SKSpriteNode){
        let spin1 = SKAction.rotateToAngle(CGFloat(0.2), duration: 0.2)
        let spin2 = SKAction.rotateToAngle(CGFloat(-0.2), duration: 0.2)
        let spin3 = SKAction.rotateToAngle(CGFloat(0), duration: 0.2)
        let group = SKAction.sequence([spin1, spin2, spin3])
        Object.runAction(group)
        
        
    }

}