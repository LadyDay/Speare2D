//
//  SceneBase.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class SceneGameBase: SceneDefault {
    
    /*SWIPE's FUNCTION */
    func addSwipes(view: UIView){
        //Add swipe in the view (self.view)
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(swipeUp)
    }
    
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
    
    //function for catch object in view
    func catchObject(gameScene: SceneGameBase, location: CGPoint, object: SKNode){
        //pega qualquer objeto da tela, que seja um skspritenode sem nome
        gameScene.mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: object.frame.size), completion: {
            //guarding the object in the inventory
            self.inventory.guardingObject(object as! SKSpriteNode)
            object.removeFromParent()
            self.touchRuning = false
        })
    }
    
    override func moveInfo(gameScene: SceneDefault) {
        gameScene.inventory = self.inventory
        self.inventory.removeFromParent()
    }
}
