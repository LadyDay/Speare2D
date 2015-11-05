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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location) as! SKSpriteNode
            
            if(!(node.name=="closet")){
                self.clearLots()
                node.color = UIColor.blackColor()
            }
            
        }
    }
    
    func clearLots(){
        for(var i = 0; i<7; i++){
            let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
            lot.color = UIColor.clearColor()
        }
    }
    
    func guardingObject(object: SKSpriteNode){
        var completed: Bool = false
        for(var i = 0; i<7 && completed==false; i++){
            let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
            if(lot.color.isEqual(UIColor.clearColor())){
                lot.color = object.color
                completed = true
            }
        }
    }
    
    func addRedNode(){
        let redSquareNode = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(50, 50))
        redSquareNode.position = CGPoint(x: 75, y: 75)
        
        self.addChild(redSquareNode)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
