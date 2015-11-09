//
//  SceneDefault.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class SceneDefault: SKScene {
    
    //inventory
    var inventory: Inventory!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    
    //mainCharacter
    var mainCharacter: Alex = Alex()
    
    //music
    var backgroundMusic: SKAudioNode!
    var applauseEffect: SKAudioNode!
    let pauseAction = SKAction.pause()
    let stopAction = SKAction.stop()
    
    /* ANOTHER FUNCTION */
    func moveInfo(gameScene: SceneDefault){
        gameScene.mainCharacter = self.mainCharacter
        gameScene.inventory = self.inventory
        self.inventory.removeFromParent()
        self.mainCharacter.removeFromParent()
    }
    
}

