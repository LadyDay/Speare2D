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
            
            //tests whether the node is one of the lot and it has texture
            if(!(node.name=="closet") && node.texture != nil){
                self.clearLots()
                let colorize = SKAction.colorizeWithColor(.greenColor(), colorBlendFactor: 1, duration: 1)
                node.runAction(colorize)
            }
            if (node.texture != nil){
                SceneGameBase.itenFromInventory = SKSpriteNode(texture: node.texture, size: CGSize(width: node.texture!.size().width, height: node.texture!.size().height))
                node.texture = nil
                SceneGameBase.itenComing = true
            }
            
        }
    }
    
    //clear color of the all lots
    func firstFunc(){
            for(var i = 0; i<7; i++){
                let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
                lot.texture = nil
                lot.color = UIColor.clearColor()
            }
    }
    
    //clear selection of the selected lot
    func clearLots(){
        for(var i = 0; i<7; i++){
            let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
            if(lot.color != .clearColor()){
                let colorize = SKAction.colorizeWithColor(.clearColor(), colorBlendFactor: 0, duration: 0.1)
                lot.runAction(colorize)
            }
        }
    }
    
    //Guar texture in the first empty lot
    func guardingObject(object: SKSpriteNode){
        var completed: Bool = false
        for(var i = 0; i<7 && completed==false; i++){
            let lot = self.childNodeWithName("lot\(i)") as! SKSpriteNode
            lot.size = CGSize(width: 110, height:110)
            if(lot.texture == nil){
                lot.texture = object.texture
                if(object.texture!.size().width > lot.size.width || object.texture!.size().height > lot.size.height){
                    lot.xScale = lot.size.width/lot.texture!.size().width
                    lot.yScale = lot.size.height/lot.texture!.size().height
                    if(lot.xScale > lot.yScale){
                        lot.yScale = lot.xScale
                    }else{
                        lot.xScale = lot.yScale
                    }
                    completed = true
                }else{
                    lot.xScale = lot.texture!.size().width/lot.size.width
                    lot.yScale = lot.texture!.size().height/lot.size.height
                    completed = true
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
