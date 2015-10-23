//
//  StartScene.swift
//  Speare2Dtela2
//
//  Created by Alessandra Pereira on 20/10/15.
//  Copyright © 2015 Alessandra Pereira. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    var gameScene: SKScene!
    var locationTouch: CGPoint!
    var mainCharacter: SKNode!
    let alexTextureAtlas = SKTextureAtlas(named: "Alex.atlas")
    var alexSpriteArray = Array<SKTexture>()
    
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        //let border = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //border.friction = 0.2
        //self.physicsBody = border
        
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        mainCharacter =  childNodeWithName("mainCharacter") as! SKSpriteNode
        mainCharacter.physicsBody?.mass = 30.0
        
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite1_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite2_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite3_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite4_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite5_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite6_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite7_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite8_128x255"))
        alexSpriteArray.append(alexTextureAtlas.textureNamed("Alex_Sprite1_128x255"))
        
    }
    
    func moveMainCharacter(touch: UITouch) -> SKAction {
        //let mainCharacter: SKSpriteNode = self.childNodeWithName("mainCharacter") as! SKSpriteNode
        //mainCharacter = SKSpriteNode(texture: alexSpriteArray[0])
        let currentLocation = touch.locationInNode(self)
        let pastLocation = mainCharacter.position
        
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
            return 1.0
        } else {
            return -1.0
        }
    }
    
    func makeDuration(currentLocation : CGPoint, pastLocation: CGPoint) -> NSTimeInterval{
        let catetos:CGFloat = pow(abs(currentLocation.x - pastLocation.x), 2) + pow(abs(currentLocation.y - pastLocation.y), 2)
        let hipotenusa = sqrt(catetos)
        
        return hipotenusa.native as NSTimeInterval //Double(hipotenusa)
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            for nodeTouched in self.nodesAtPoint(location){
                switch nodeTouched.name!{
                case "tutorial":
                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //Muda cena para Opção1
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        self.gameScene = TutorialScene(fileNamed: "TutorialScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
                    break
                    
                case "option2":
                    //chama a animação para a porta
                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //Muda cena para Opção3
                    })
                    break
                    
                case "option3":
                    //chama a animação para a bilheteria
                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //Muda cena para Opção3
                    })
                    break
                    
                default:
                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //mainCharacter = SKSpriteNode(texture:self.alexSpriteArray[0])
                    })
                    break
                }
            }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
        if mainCharacter.position.x < 40.0 {
            self.camera?.position = CGPoint(x: 40, y: 387.942)
        } else if mainCharacter.position.x > 1080.0 {
            self.camera?.position = CGPoint(x: 1080.0, y: 387.942)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 387.942)
        }
        
    }
    
    override func didSimulatePhysics() {
        //<#code#>
    }
    
    
}
