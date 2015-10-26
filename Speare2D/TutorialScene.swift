//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    var viewInventory: SKView!
    var gameScene: SKScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeUp)
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        
        self.viewInventory = SKView(frame: CGRectMake(0, 0, 1024, 150))
        
        self.view?.addSubview(viewInventory as UIView)
        //for nodeTest in self.nodesAtPoint(sender.locationInView(self.view)){
          //  print("\(nodeTest.name)")
            //if(nodeTest.name=="viewCloset"){
                let transition = SKTransition.crossFadeWithDuration(2)
                self.gameScene = Inventory(fileNamed: "Inventory")
                viewInventory.presentScene(gameScene, transition: transition)
            //}
        //}
    }
    
    func swipeUp(sender: UISwipeGestureRecognizer){
        viewInventory.removeFromSuperview()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}