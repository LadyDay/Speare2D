//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SceneGameBase {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        mainCharacter.name = "Alex"
        
        //Make in inventory for the scene
        self.inventory = Inventory(fileNamed: "Inventory")
        //clear the inventory (textures and colors)
        self.inventory.firstFunc()
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(mainCharacter)
        setCamera()
    }
    
/*TOUCH's FUCTION */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(!self.touchRuning){
            self.touchRuning = true
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            
            //for nodeTouched in self.nodesAtPoint(location){
            if let nodeTouched: SKNode = self.nodeAtPoint(location){
                
                if(nodeTouched.name == nil){
                    self.catchObject(self, location: location, object: nodeTouched)
                    
                }else{
                    switch nodeTouched.name!{
                    case "hortaNode":
                        //changes the scene for the garden
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                            let gameScene = FarmScene(fileNamed: "FarmScene")
                            self.moveInfo(gameScene!)
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                        })
                        break
                        
                    default:
                        if(inventoryPresent==false && location.y<200){
                            //mainCharacter walks
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
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateCamera()
    }
    
}