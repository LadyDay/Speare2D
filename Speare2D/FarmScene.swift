//
//  FarmScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 26/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class FarmScene: SceneDefault {
    
    var countDoorAnimation: Int = 0
    var doorArray = Array<SKTexture>()
    let doorAtlas = SKTextureAtlas(named: "portaHorta.atlas")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.fileName = "FarmScene"
        self.numberLevel = 0
        
        Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "currentScene", object: self.fileName)
        
        setCamera()
        setPositionCamera()
        initDoorTexture()

    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(self.touchRuning == false && theater.pauseMenuPresent == false && theater.flagStartTouchedBeganTheater == false){
            self.touchRuning = true
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                
                //for nodeTouched in self.nodesAtPoint(location){
                let index = theater.nodesAtPoint(location).startIndex.advancedBy(1)
                if let nodeTouched: SKNode = theater.nodesAtPoint(location)[index] {

                    switch nodeTouched.name!{
                        
                    case "homeNode":
                        theater.removeVisionButtonsScene()
                        //changes the scene for the garden
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = TutorialScene(fileNamed: "TutorialScene")
                            self.theater.fileName = "TutorialScene"
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false, completion: {
                                self.theater!.mainCharacter.position.x = 1881
                                if(self.theater!.mainCharacter.xScale>0){
                                    self.theater!.mainCharacter.xScale = self.theater!.mainCharacter.xScale * (-1)
                                }
                            })
                            self.theater.showVisionButtonsScene()
                        })
                        break
                    case "casaNode":
                        theater.removeVisionButtonsScene()
                        //changes the scene for the garden
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = KitchenScene(fileNamed: "KitchenScene")
                            self.theater.fileName = "KitchenScene"
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false, completion: {
                                self.theater!.mainCharacter.position.x = 1881
                                if(self.theater!.mainCharacter.xScale>0){
                                    self.theater!.mainCharacter.xScale = self.theater!.mainCharacter.xScale * (-1)
                                }
                            })
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    default:
                        theater.removeVisionButtonsScene()
                        if(theater.inventoryPresent==false && location.y<200){
                            //mainCharacter walks
                            theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                self.theater.showVisionButtonsScene()
                                self.touchRuning = false
                                self.theater.showVisionButtonsScene()
                            })
                        }else{
                            self.touchRuning = false
                        }
                        break
                    }
                }else{
                    self.touchRuning = false
                }
            }else{
                self.touchRuning = false
            }
        }
    }
    
    func initDoorTexture(){
        doorArray.append(doorAtlas.textureNamed("portaHorta1"))
        doorArray.append(doorAtlas.textureNamed("portaHorta2"))
        doorArray.append(doorAtlas.textureNamed("portaHorta3"))
        doorArray.append(doorAtlas.textureNamed("portaHorta2"))
        doorArray.append(doorAtlas.textureNamed("portaHorta1"))
        

    }
    func animationDoor(doorNode: SKSpriteNode){
        let doorAnimation = SKAction.repeatAction(SKAction.animateWithTextures(doorArray, timePerFrame: 0.1), count: 1)
        doorNode.runAction(doorAnimation)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(countDoorAnimation == 200){
            countDoorAnimation = 0
            if(!touchRuning){
                self.animationDoor(self.theater.childNodeWithName("casaNode") as! SKSpriteNode)
            }
        }else{
            countDoorAnimation++
        }
    }
}
