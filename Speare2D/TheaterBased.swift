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
        
        let sceneBaseView = self.view!.superview! as! SKView
        self.camera = sceneBaseView.scene!.camera
    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let sceneBaseView = self.view!.superview! as! SKView
        let sceneBase = sceneBaseView.scene!
        sceneBase.touchesBegan(touches, withEvent: event)
        
        //a vida é uma bosta
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateCameraSceneDefault()
    }
    
}
