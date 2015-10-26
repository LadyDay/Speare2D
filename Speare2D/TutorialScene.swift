//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    var gameScene: SKScene!
    var locationTouch: CGPoint!
    var mainCharacter: SKNode!
    let alexTextureAtlas = SKTextureAtlas(named: "Alex128.atlas")
    var alexSpriteArray = Array<SKTexture>()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        
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
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        
        //for nodeTest in self.nodesAtPoint(sender.locationInView(self.view)){
            //if(nodeTest.name=="viewCloset"){
            if(sender.locationInView(self.view).y < 350 && inventoryPresent==false){
                self.viewInventory = SKView(frame: CGRectMake(0, 0, 1024, 150))
                self.view?.addSubview(viewInventory as UIView)
                inventoryPresent = true
                
                let transition = SKTransition.crossFadeWithDuration(2)
                self.gameScene = Inventory(fileNamed: "Inventory")
                viewInventory.presentScene(gameScene, transition: transition)
            }
            //}
        //}
        
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
    
    func swipeUp(sender: UISwipeGestureRecognizer){
        if(inventoryPresent==true){
            viewInventory.removeFromSuperview()
            inventoryPresent = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            for nodeTouched in self.nodesAtPoint(location){
                switch nodeTouched.name!{
                case "hortaNode":
                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //Muda cena para Opção1
                        let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                        self.gameScene = FarmScene(fileNamed: "FarmScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
                    break
                    
                case "option2":
//                    //chama a animação para a porta
//                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
//                        //Muda cena para Opção3
//                    })
                    break
                    
                case "option3":
//                    //chama a animação para a bilheteria
//                    mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
//                        //Muda cena para Opção3
//                    })
                    break
                    
                default:
                    if(inventoryPresent==false){
                        mainCharacter.runAction(self.moveMainCharacter(touch), completion: {
                        //mainCharacter = SKSpriteNode(texture:self.alexSpriteArray[0])
                        })
                    }
                    break
                }
            }
        }

    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
    
}