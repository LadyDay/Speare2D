//
//  Inventory.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class Inventory: SKScene {
    
    var gameScene: SKScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeUp)
    }
    
    func swipeUp(sender: UISwipeGestureRecognizer){
        let nodeTest = self.nodeAtPoint(sender.locationInView(self.view))
        if(nodeTest.name=="viewCloset"){
            self.gameScene = TutorialScene(fileNamed: "TutorialScene")
            self.view?.presentScene(self.gameScene!)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location) as! SKSpriteNode
            
            self.clearLots()
            
            node.color = UIColor.blackColor()
            
        }
    }
    
    func clearLots(){
        for(var i = 0; i<10; i++){
            let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
            lot.color = UIColor.redColor()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
