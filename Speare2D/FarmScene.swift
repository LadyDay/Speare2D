//
//  FarmScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 26/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class FarmScene: SKScene {
    var viewInventory: SKView!
    var gameScene: SKScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        self.view?.addSubview(viewInventory as UIView)
        //for nodeTest in self.nodesAtPoint(sender.locationInView(self.view)){
        //  print("\(nodeTest.name)")
        //if(nodeTest.name=="viewCloset"){
        let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 2)
        self.gameScene = Inventory(fileNamed: "Inventory")
        viewInventory.presentScene(gameScene, transition: transition)
        //}
        //}
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
