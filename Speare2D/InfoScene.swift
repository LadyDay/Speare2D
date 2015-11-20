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
        musicBgConfiguration(optionsBGmusic)
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
                        //self.transitionNextScene(IntroScene(fileNamed: "IntroScene")!, withTheater: true)
                        break
                        
                    case "ticketBackButton":
                        effectConfiguration(backButtonSound, waitC: true)
                        self.transitionNextScene(Home(fileNamed: "Home")!, withTheater: false)
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
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }

}