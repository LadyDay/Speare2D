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
        setCamera()
        setPositionCamera()
        initTextureAnimation()
        //initFogao(self.childNodeWithName("fogao") as! SKSpriteNode)
        //initPanela(self.childNodeWithName("panela") as! SKSpriteNode)
    }
    
//    /*TOUCH's FUCTION */
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        /* Called when a touch begins */
//        
//        if(self.touchRuning == false && theater.pauseMenuPresent == false){
//            self.touchRuning = true
//            if let touch = touches.first {
//                let location = touch.locationInNode(self)
//                
//                //for nodeTouched in self.nodesAtPoint(location){
//                if let nodeTouched: SKNode = theater.nodeAtPoint(location){
//                    if(nodeTouched.name != nil){
//                        //self.catchObject(self.theater, location: location, object: nodeTouched)
//                        //}else{
//                        switch nodeTouched.name!{
//                        case "hortaNode":
//                            //changes the scene for the garden
//                            theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
//                                self.touchRuning = false
//                                self.transitionNextScene(FarmScene(fileNamed: "FarmScene")!, withTheater: true)
//                            })
//                            break
//                        case "casaNode":
//                            //changes the scene for the garden
//                            theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
//                                self.touchRuning = false
//                                self.transitionNextScene(KitchenScene(fileNamed: "KitchenScene")!, withTheater: true)
//                            })
//                            break
//                            
//                        default:
//                            if(theater.inventoryPresent==false && location.y<200){
//                                //mainCharacter walks
//                                theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
//                                    self.touchRuning = false
//                                })
//                            }else{
//                                self.touchRuning = false
//                            }
//                            break
//                        }
//                    }
//                }
//            }
//        }
//        self.touchRuning = false
//    }
    
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
    
    func initFogao(objNode: SKSpriteNode){
        fogaoAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(fogaoArray, timePerFrame: 0.04))
        objNode.runAction(fogaoAnimation)
    }
    func initPanela(objNode: SKSpriteNode){
        panelaAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(panelaArray, timePerFrame: 0.08))
        objNode.runAction(panelaAnimation)
    }
    
}