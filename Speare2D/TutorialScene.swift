//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    var inventory: Inventory!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    var gameScene: SKScene!
    var locationTouch: CGPoint!
    var mainCharacter: Alex = Alex()
    
    func setupAlex(){
        mainCharacter.position = CGPoint(x:167, y:243)
        mainCharacter.zPosition = 100.0
        mainCharacter.xScale = 0.1
        mainCharacter.yScale = 0.1
        addChild(mainCharacter)
        
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //Make in inventory for the scene
        self.inventory = Inventory(fileNamed: "Inventory")
        //clear the inventory (textures and colors)
        self.inventory.firstFunc()
        
        //Add swipe in the view (self.view)
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        
        //call function setupAlex
        setupAlex()
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        /* Function to display the inventory */
        if(sender.locationInView(self.view).y < 350 && inventoryPresent==false){ //limits the recognition area swipe
            self.viewInventory = SKView(frame: CGRectMake(0, 0, 1024, 150))
            self.view?.addSubview(viewInventory as UIView)
            inventoryPresent = true
                
            let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 5)
            viewInventory.presentScene(inventory, transition: transition)
        }else{
            /* Function to use swipe on the main chaacter */
            
        }
    }
    
    func swipeUp(sender: UISwipeGestureRecognizer){
        if(inventoryPresent==true){
            viewInventory.removeFromSuperview()
            inventoryPresent = false
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            for nodeTouched in self.nodesAtPoint(location){
                switch nodeTouched.name!{
                case "hortaNode":
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location), completion: {
                        //Muda cena para Opção1
                        let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                        self.gameScene = FarmScene(fileNamed: "FarmScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
                    break
                    
                case "option2":
                    //chama a animação para o objeto
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                    //Muda cena para Opção3
                        
                    })
                    break
                    
                    //Tentando 
                case "chave":
                    //inventário
                    //vai até o objeto
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location), completion: {
                        //Muda cena para Opção1
                        let redNode = self.childNodeWithName("chave") as! SKSpriteNode
                        //let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                        let rotateAction = SKAction.rotateByAngle(3.14, duration: 1.0)
                        redNode.runAction(rotateAction)
                        //redNode!.removeFromParent()
                        self.inventory.guardingObject(redNode)
                        redNode.removeFromParent()
                    })
                    
                    
                    break
                    
                case "option3":
                    //vai até o objeto
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: location), completion: {
                        //Muda cena para Opção1
                        let fadeScene = SKTransition.crossFadeWithDuration(1.5)
                        self.gameScene = FarmScene(fileNamed: "FarmScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
//                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
//                        //Muda cena para Opção3
//                    })
                    break
                    
                default:
                    if(inventoryPresent==false){
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
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