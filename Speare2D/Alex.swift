//
//  GameScene.swift
//  ClasseDaAlex
//
//  Created by Alessandra Pereira on 28/10/15.
//  Copyright (c) 2015 Alessandra Pereira. All rights reserved.
//

import SpriteKit

class Alex: SKSpriteNode {

    var offsetAlexWalk: CGFloat!
    let alexTextureAtlas = SKTextureAtlas(named: "AlexCorrendo.atlas")
    var alexSpriteArray = Array<SKTexture>()
    var waitingAlexSpriteArray = Array<SKTexture>()
    var scaleAlex: CGFloat = 0.3
    var alexIsWalking: Bool = false
    
    init() {
        //Initializing alex with her first sprite
        let texture = SKTexture(imageNamed: "Alex_Sprite_Princ1_400x708")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        //Appending sprites for animation
        initWalkingSprites()
        initBlinkingSprites()
        
        //Making alex blink
        blinkingAlex()
    }
    
    func initWalkingSprites(){
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr1_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr2_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr3_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr4_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr5_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr6_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr7_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr8_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr9_400x708"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Corr10_400x708"))
    }
    
    func initBlinkingSprites(){
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ2_400x708"))
        waitingAlexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite_Princ1_400x708"))
    }

    //It is necessary because of the init() function
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Function to the default position of Alex
    func setupAlex(){
        self.position = CGPoint(x:167, y:220)
        self.zPosition = 98.0
        self.xScale = scaleAlex
        self.yScale = scaleAlex
    }
    
    
    
    ////MOTION FUNCTIONS
    
    //Functions to implement
    func jump(){
        
    }
    
    func crouch(){
        
    }
    
    //Blink eyes - Waiting animation
    func blinkingAlex(){
        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(waitingAlexSpriteArray, timePerFrame: 0.2))
        self.runAction(playerAnimation)
    }
    
    //Function to walk
    func walk(inicialLocation: CGPoint, touchLocation: CGPoint, tamSize: CGFloat, objectPresent: Bool, objectSize: CGSize?) -> SKAction {
        
        self.removeActionForKey("andando")
        let pastLocation = inicialLocation
        var currentLocation: CGPoint
        
        if(objectPresent){
            if(inicialLocation.x < touchLocation.x - self.frame.size.width/2){
                currentLocation = CGPointMake(touchLocation.x - self.frame.size.width/2 - (objectSize?.width)!/2, touchLocation.y)
            }else{
                currentLocation = CGPointMake(touchLocation.x + self.frame.size.width/2 + (objectSize?.width)!/2, touchLocation.y)
            }
        }else{
            if(touchLocation.x < self.frame.size.width/2 + self.offsetAlexWalk){
                currentLocation = CGPointMake(self.frame.size.width/2 + self.offsetAlexWalk, touchLocation.y)
            }else if(touchLocation.x > tamSize - self.frame.size.width/2 - self.offsetAlexWalk){
                currentLocation = CGPointMake(tamSize - self.frame.size.width/2 - self.offsetAlexWalk, touchLocation.y)
            }else{
                currentLocation = touchLocation
            }
        }
        
        let duration : NSTimeInterval = makeDuration(currentLocation, pastLocation: pastLocation)/400
        let moveToPoint = SKAction.moveToX(currentLocation.x, duration: duration)
        let walkingAlexAction = SKAction.repeatActionForever(SKAction.animateWithTextures(self.alexSpriteArray, timePerFrame: 0.08, resize: true, restore: true))
        let direction = SKAction.scaleXTo((directionCharacter(touchLocation, pastLocation: pastLocation)), duration: 0)
        let sequence = SKAction.sequence([SKAction.group([direction, moveToPoint]), SKAction.runBlock({self.removeActionForKey("andando")})])
        let group = SKAction.group([sequence, SKAction.runBlock({self.runAction(walkingAlexAction, withKey: "andando")})])
        
        return group
    }
    
    func walkWithSound(inicialLocation: CGPoint, touchLocation: CGPoint, tamSize: CGFloat, objectPresent: Bool, objectSize: CGSize?, sound: String) -> SKAction {
    
        let walkAct = walk(inicialLocation, touchLocation: touchLocation, tamSize: tamSize, objectPresent: objectPresent, objectSize: objectSize)
        let sound = SKAction.repeatActionForever(SKAction.playSoundFileNamed("Passos na madeira/mp3", waitForCompletion: false))
        let delay = SKAction.waitForDuration((4*0.08))
        let sequence = SKAction.sequence([sound, delay])
        let group = SKAction.group([walkAct, sequence])
        return group
    }
    
    
    //Function to determine which way Alex should point.
    func directionCharacter(currentLocation : CGPoint, pastLocation: CGPoint) -> CGFloat{
        if(currentLocation.x > pastLocation.x){
            
            return scaleAlex
        } else {
            
            return -scaleAlex
        }
    }
    
    //Function for timing compass
    func makeDuration(currentLocation : CGPoint, pastLocation: CGPoint) -> NSTimeInterval{
        let catetos:CGFloat = pow(abs(currentLocation.x - pastLocation.x), 2) + pow(abs(currentLocation.y - pastLocation.y), 2)
        let hipotenusa = sqrt(catetos)
        
        return Double(hipotenusa.native) as NSTimeInterval //Double(hipotenusa)
    }
    
}
