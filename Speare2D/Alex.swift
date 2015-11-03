//
//  GameScene.swift
//  ClasseDaAlex
//
//  Created by Alessandra Pereira on 28/10/15.
//  Copyright (c) 2015 Alessandra Pereira. All rights reserved.
//

import SpriteKit

class Alex: SKSpriteNode {
    
    var gameScene: SKScene!
    var locationTouch: CGPoint!
    var mainCharacter: SKNode!
    let alexTextureAtlas = SKTextureAtlas(named: "Alex1024.atlas")
    var alexSpriteArray = Array<SKTexture>()
    
    init() {
        let texture = SKTexture(imageNamed: "Alex_Sprite1_1024x2040")
        
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite1_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite2_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite3_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite4_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite5_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite6_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite7_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite8_1024x2040"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite1_1024x2040"))
        
        
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate(){
        //        var playerTextures:[SKTexture] = []
        //        for i in 1...2 {
        //            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
        //        }
        //        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(playerTextures, timePerFrame: 0.1))
        //        self.runAction(playerAnimation)
    }
    
    
    func jump(){
        
    }
    
    func crouch(){
        
    }
    
    func walk(inicialLocation: CGPoint, touchLocation: CGPoint ) -> SKAction {
        
        let currentLocation = touchLocation
        let pastLocation = inicialLocation
        
        let duration : NSTimeInterval = makeDuration(currentLocation, pastLocation: pastLocation)/400
        let moveToPoint = SKAction.moveToX(currentLocation.x, duration: duration)
        let walkingAlexAction = SKAction.animateWithTextures(self.alexSpriteArray, timePerFrame: 0.05)
        walkingAlexAction.duration = 1
        let direction = SKAction.scaleXTo((directionCharacter(currentLocation, pastLocation: pastLocation)), duration: 0)
        let group = SKAction.group([walkingAlexAction, direction, moveToPoint])
        return group
    }
    
    func directionCharacter(currentLocation : CGPoint, pastLocation: CGPoint) -> CGFloat{
        //let xVar: Int
        if (currentLocation.x - pastLocation.x) > 0 {
            return 0.1
        } else {
            return -0.1
        }
    }
    
    func makeDuration(currentLocation : CGPoint, pastLocation: CGPoint) -> NSTimeInterval{
        let catetos:CGFloat = pow(abs(currentLocation.x - pastLocation.x), 2) + pow(abs(currentLocation.y - pastLocation.y), 2)
        let hipotenusa = sqrt(catetos)
        
        return hipotenusa.native as NSTimeInterval //Double(hipotenusa)
    }
    
}
