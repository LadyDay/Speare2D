//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    var inventory: Inventory!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    var locationTouch: CGPoint!
    var mainCharacter: Alex = Alex()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        mainCharacter.name = "Alex"
        
        //Make in inventory for the scene
        self.inventory = Inventory(fileNamed: "Inventory")
        //clear the inventory (textures and colors)
        self.inventory.firstFunc()
        
        //Add swipe in the view (self.view)
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(mainCharacter)
    }

/*SWIPE's FUCTION */
    func swipeDown(sender: UISwipeGestureRecognizer){
        /* Function to display the inventory */
        if(sender.locationInView(self.view).y < 350 && inventoryPresent==false){ //limits the recognition area swipe
            self.viewInventory = SKView(frame: CGRectMake(0, 0, 1024, 150))
            self.view?.addSubview(viewInventory as UIView)
            inventoryPresent = true
                
            let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 5)
            viewInventory.presentScene(inventory, transition: transition)
        }else{
            /* Function to use swipe on the main chaacter */
            
        }
    }
    
    func swipeUp(sender: UISwipeGestureRecognizer){
        if(inventoryPresent==true){
            viewInventory.removeFromSuperview()
            inventoryPresent = false
        }
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