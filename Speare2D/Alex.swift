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
    let alexTextureAtlas = SKTextureAtlas(named: "AlexCorrendo.atlas")
    var alexSpriteArray = Array<SKTexture>()
    var waitingAlexSpriteArray = Array<SKTexture>()
    
    init() {
        let texture = SKTexture(imageNamed: "Alex_Sprite_Princ1_400x708")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        //animate()
        
        
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr1_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr2_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr3_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr4_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr5_400x708"))
        //alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr6_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr7_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr8_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr9_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr10_400x708"))
        //alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr11_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        
        
        
        animate()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate(){
        
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ2_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(waitingAlexSpriteArray, timePerFrame: 0.5))
        self.runAction(playerAnimation)
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
        let walkingAlexAction = SKAction.animateWithTextures(self.alexSpriteArray, timePerFrame: 0.08)
        walkingAlexAction.duration = duration
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
