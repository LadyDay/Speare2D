//
//  GameScene.swift
//  ClasseDaAlex
//
//  Created by Alessandra Pereira on 28/10/15.
//  Copyright (c) 2015 Alessandra Pereira. All rights reserved.
//

import SpriteKit

class Alex: SKSpriteNode {

    let alexTextureAtlas = SKTextureAtlas(named: "AlexCorrendo.atlas")
    var alexSpriteArray = Array<SKTexture>()
    var waitingAlexSpriteArray = Array<SKTexture>()
    var waitingAlexSpriteArray2 = Array<SKTexture>()
    var scaleAlex: CGFloat = 0.3
    
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
        //alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        
        
        
        animate()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate(){
        
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ2_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        
        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(waitingAlexSpriteArray, timePerFrame: 0.2))
//        waitingAlexSpriteArray2.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
//        waitingAlexSpriteArray2.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ2_400x708"))
//        let playerAnimation2 = SKAction.repeatActionForever( SKAction.animateWithTextures(waitingAlexSpriteArray2, timePerFrame: 0.1))
//        let waitingAnimation = SKAction.group([playerAnimation, playerAnimation2])
        self.runAction(playerAnimation)
    }
    
    
    func jump(){
        
    }
    
    func crouch(){
        
    }
    
    func setupAlex(){
        self.position = CGPoint(x:167, y:200)
        self.zPosition = 100.0
        self.xScale = scaleAlex
        self.yScale = scaleAlex
    }
    
    func walk(inicialLocation: CGPoint, touchLocation: CGPoint ) -> SKAction {
        
        self.removeActionForKey("andando")
        
        let currentLocation = touchLocation
        let pastLocation = inicialLocation
        
        let duration : NSTimeInterval = makeDuration(currentLocation, pastLocation: pastLocation)/400
        let moveToPoint = SKAction.moveToX(currentLocation.x, duration: duration)
        
        let walkingAlexAction = SKAction.repeatActionForever(SKAction.animateWithTextures(self.alexSpriteArray, timePerFrame: 0.08, resize: true, restore: true))
        let direction = SKAction.scaleXTo((directionCharacter(currentLocation, pastLocation: pastLocation)), duration: 0)
        let sequence = SKAction.sequence([SKAction.group([direction, moveToPoint]), SKAction.runBlock({self.removeActionForKey("andando")})])
        let group = SKAction.group([sequence, SKAction.runBlock({self.runAction(walkingAlexAction, withKey: "andando")})])
        
        return group
    }
    
    func directionCharacter(currentLocation : CGPoint, pastLocation: CGPoint) -> CGFloat{
        //let xVar: Int
        if (currentLocation.x - pastLocation.x) > 0 {
            return scaleAlex
        } else {
            return -scaleAlex
        }
    }
    
    func makeDuration(currentLocation : CGPoint, pastLocation: CGPoint) -> NSTimeInterval{
        let catetos:CGFloat = pow(abs(currentLocation.x - pastLocation.x), 2) + pow(abs(currentLocation.y - pastLocation.y), 2)
        let hipotenusa = sqrt(catetos)
        
        return hipotenusa.native as NSTimeInterval //Double(hipotenusa)
    }
    
}
