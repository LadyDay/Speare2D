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
    var mainCharacter: Alex = Alex ()
    
    func setupAlex(){
        mainCharacter.position = CGPoint(x:76, y:210)
        addChild(mainCharacter)
    }
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        setupAlex()
        
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            var location = touch.locationInNode(self)
            for nodeTouched in self.nodesAtPoint(location){
                switch nodeTouched.name!{
                case "tutorial":
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                        //Muda cena para Opção1
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        self.gameScene = TutorialScene(fileNamed: "TutorialScene")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
                    break
                    
                case "option2":
                    //chama a animação para a porta
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                        //Muda cena para Opção3
                    })
                    break
                    
                case "option3":
                    //chama a animação para a bilheteria
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                        //Muda cena para Opção3
                    })
                    break
                    
                case "exitNode":
                    //chama a animação para a bilheteria
                    location = CGPoint(x: -70, y: 300)
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                        //Volta ao menu
                        let fadeScene = SKTransition.fadeWithDuration(1.5)
                        self.gameScene = Home(fileNamed: "Home")
                        self.view?.presentScene(self.gameScene!, transition: fadeScene)
                    })
                    break
                    
                default:
                    mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self)), completion: {
                        //mainCharacter = SKSpriteNode(texture:self.alexSpriteArray[0])
                    })
                    break
                }
            }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
        if mainCharacter.position.x < 476.0 {
            self.camera?.position = CGPoint(x: 476, y: 387.942)
        } else if mainCharacter.position.x > 545.0 {
            self.camera?.position = CGPoint(x: 545.0, y: 387.942)
        } else {
            self.camera?.position = CGPoint(x: mainCharacter.position.x, y: 387.942)
        }
        
    }
    
    override func didSimulatePhysics() {
        //<#code#>
    }
    
    
}
