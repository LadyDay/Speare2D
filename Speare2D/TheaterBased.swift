//
//  theaterBased.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 12/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TheaterBased: SceneGameBase {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        mainCharacter.name = "Alex"
        
        //clear the inventory (textures and colors)
        self.inventory.firstFunc()
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(mainCharacter)
        
        //addChild(mainCharacter)
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
                    let SceneBase = self.view?.superclass as! SceneGameBase
                    
                }
            }
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateCameraSceneDefault()
    }
    
}
