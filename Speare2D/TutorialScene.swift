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
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(swipeUp)
        setupAlex()
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        /* Function to display the inventory */
        if(sender.locationInView(self.view).y < 350 && inventoryPresent==false){
            self.viewInventory = SKView(frame: CGRectMake(0, 0, 1024, 150))
            self.view?.addSubview(viewInventory as UIView)
            inventoryPresent = true
                
            let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 5)
            self.gameScene = Inventory(fileNamed: "Inventory")
            viewInventory.presentScene(gameScene, transition: transition)
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
//                    //chama a animação para a porta
//                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
//                        //Muda cena para Opção3
//                    })
                    break
                    
                case "option3":
//                    //chama a animação para a bilheteria
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