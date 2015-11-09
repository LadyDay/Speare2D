//
//  FarmScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 26/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class FarmScene: SceneBase {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(self.mainCharacter)
    }
    
/*TOUCH's FUCTION */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            for nodeTouched in self.nodesAtPoint(location){
                
                if(nodeTouched.name == nil){
                    self.catchObject(self, location: location, object: nodeTouched)
                    
                }else{
                    switch nodeTouched.name!{
                        
                    default:
                        if(inventoryPresent==false){
                            //mainCharacter walks
                            mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {})
                        }
                        break
                    }
                }
            }
        }
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
