//
//  KitchenScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 26/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class KitchenScene: SceneDefault {
    var panelaArray = Array<SKTexture>()
    let panelaAtlas = SKTextureAtlas(named: "panela.atlas")
    var fogaoArray = Array<SKTexture>()
    let fogaoAtlas = SKTextureAtlas(named: "fogao.atlas")
    var panelaAnimation = SKAction()
    var fogaoAnimation = SKAction()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.fileName = "KitchenScene"
        self.numberLevel = 0
        
        self.offsetWalkScene = 100
        setCamera()
        setPositionCamera()
        initTextureAnimation()
    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(self.touchRuning == false && theater.pauseMenuPresent == false && theater.flagStartTouchedBeganTheater == false){
            self.touchRuning = true
            if let touch = touches.first {
                let location = touch.locationInNode(theater)
                
                //for nodeTouched in self.nodesAtPoint(location){
                let index = theater.nodesAtPoint(location).startIndex.advancedBy(1)
                if let nodeTouched: SKNode = theater.nodesAtPoint(location)[index] {
                    
                    switch nodeTouched.name!{
                    case "panela":
                        //mexer a panela
                        animationPanela()
                        self.touchRuning = false
                        break
                        
                    case "fogao":
                        //acender o fogão
                        animationFogao()
                        self.touchRuning = false
                        break
                        
                    case "hortaNode":
                        theater.removeVisionButtonsScene()
                        //changes the scene for the garden
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = FarmScene(fileNamed: "FarmScene")
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false)
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    case "tutorialScene":
                        theater.removeVisionButtonsScene()
                        //changes the scene for the garden
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = TutorialScene(fileNamed: "TutorialScene")
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false)
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    default:
                        if(theater.inventoryPresent==false && location.y<200){
                            //mainCharacter walks
                            theater.removeVisionButtonsScene()
                            theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                self.theater.showVisionButtonsScene()
                                self.touchRuning = false
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
    
    func initTextureAnimation() {
        panelaArray.append(panelaAtlas.textureNamed("panela1"))
        panelaArray.append(panelaAtlas.textureNamed("panela2"))
        panelaArray.append(panelaAtlas.textureNamed("panela3"))
        panelaArray.append(panelaAtlas.textureNamed("panela4"))
        fogaoArray.append(fogaoAtlas.textureNamed("fogao1"))
        fogaoArray.append(fogaoAtlas.textureNamed("fogao2"))
        fogaoArray.append(fogaoAtlas.textureNamed("fogao3"))
        fogaoArray.append(fogaoAtlas.textureNamed("fogao4"))
        fogaoArray.append(fogaoAtlas.textureNamed("fogao5"))
    }
    
    func animationFogao(){
        fogaoAnimation = SKAction.repeatAction(SKAction.animateWithTextures(fogaoArray, timePerFrame: 0.08, resize: true, restore: true), count: 2)
        (theater.childNodeWithName("fogao") as! SKSpriteNode).runAction(fogaoAnimation)
    }
    func animationPanela(){
        panelaAnimation = SKAction.repeatAction(SKAction.animateWithTextures(panelaArray, timePerFrame: 0.08, resize: true, restore: true), count: 2)
        (theater.childNodeWithName("panela") as! SKSpriteNode).runAction(panelaAnimation)
    }
    
}