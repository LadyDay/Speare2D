//
//  FarmScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 26/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class FarmScene: SceneDefault {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //setCamera()
    }
    
/*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(self.touchRuning == false && theater.pauseMenuPresent == false){
            self.touchRuning = true
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                
                //for nodeTouched in self.nodesAtPoint(location){
                if let nodeTouched: SKNode = theater.nodeAtPoint(location){
                    
                    if(nodeTouched.name == nil){
                        self.catchObject(self.theater, location: location, object: nodeTouched)
                    }else{
                        switch nodeTouched.name!{
                            
                        default:
                            if(theater.inventoryPresent==false && location.y<200){
                                //mainCharacter walks
                                theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
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
    }
}
