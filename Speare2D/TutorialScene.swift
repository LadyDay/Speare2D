//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SceneBase {
    
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
    }
    
/*TOUCH's FUCTION */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            for nodeTouched in self.nodesAtPoint(location){
                
                if(nodeTouched.name == nil){
                    //pega qualquer objeto da tela, que seja um skspritenode sem nome
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location), completion: {
                        //guarding the object in the inventory
                        self.inventory.guardingObject(nodeTouched as! SKSpriteNode)
                        nodeTouched.removeFromParent()
                    })
                    
                }else{
                    switch nodeTouched.name!{
                    case "hortaNode":
                        //changes the scene for the garden
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location), completion: {
                            let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                            let gameScene = FarmScene(fileNamed: "FarmScene")
                            gameScene!.mainCharacter = self.mainCharacter
                            gameScene!.inventory = self.inventory
                            self.inventory.removeFromParent()
                            self.mainCharacter.removeFromParent()
                            self.view?.presentScene(gameScene!, transition: fadeScene)
                        })
                        break
                        
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
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
    
}