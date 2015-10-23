//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    var gameScene: SKScene!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        /*
        let swipeInventoryUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeInventoryUp")
        swipeInventoryUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeInventoryUp)
        */
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        for nodeTest in self.nodesAtPoint(sender.locationInView(self.view)){
            print("\(nodeTest.name)")
            if(nodeTest.name=="viewCloset"){
                self.gameScene = Inventory(fileNamed: "Inventory")
                self.view?.presentScene(self.gameScene!)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}