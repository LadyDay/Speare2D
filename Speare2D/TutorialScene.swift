//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SceneDefault {
    var fireArray = Array<SKTexture>()
    let fireAtlas = SKTextureAtlas(named: "fogoCaldeira.atlas")
    var fireAnimation = SKAction()
    var ballon = SKView(frame: CGRectMake(0, 0, 187.25, 107.75))
    var ballonIsPresented: Bool = false
    var ballonTraveller: Int!
    var ballonOldie: Int!
    var firstPresented = 0
    var imageBallon: UIImage!
    var imageViewBallon: UIImageView!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setCamera()
        setPositionCamera()
        initTextureFire()
        initFire(self.childNodeWithName("fire") as! SKSpriteNode)
        ballon.center = CGPointMake(512.0, 384.0)
        
        if (firstPresented == 0){
            firstPresented = 1
            ballonTraveller = 0
            ballonOldie = 0
        }
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
                        
                    case "hortaNode":
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = FarmScene(fileNamed: "FarmScene")
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false)
                            self.theater.showVisionButtonsScene()
                        })
                        break
                    case "casaNode":
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = KitchenScene(fileNamed: "KitchenScene")
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false)
                            self.theater.showVisionButtonsScene()
                        })
                        break
                    case "viajante":
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            // o que fazer?
                            self.view?.addSubview(self.ballon as UIView)
                            
                            switch self.ballonTraveller{
                            case 0:
                                //balao chamando para ajudar na sopa
                                //sim ou nao
                                break
                            case 1:
                                //balao listando ingredientes
                                //informativo
                                break
                            case 2:
                                //balao quando todos os ingredientes foram entregues
                                //a sopa ta pronta
                                //informativo
                                break
                            case 3:
                                // vamos dividir com a velha?
                                //sim ou nao
                                break
                            default:
                                //mensagem padrao?
                                //self.imageBallon = UIImage(named: "imageBackName")
                                //self.imageViewBallon = UIImageView(image: self.imageBallon)
                                //imageViewBallon.frame = CGRectMake(0, 0, 187.25, 107.75)
                                break
                                
                            }
                            //
                            //self.ballon.addSubview(imageView)
                            //self.ballon.cheetah.scale(3).duration(0.5).run()
                            //
                            self.theater.showVisionButtonsScene()
                            
                        })
                        break
                        
                    case "velha":
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            // baloes
                            
                            
                            //
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
                }
            }else{
                self.touchRuning = false
            }
        }
    }
    
    func initTextureFire() {
        fireArray.append(fireAtlas.textureNamed("fogo1"))
        fireArray.append(fireAtlas.textureNamed("fogo2"))
    }
    
    func initFire(fireNode: SKSpriteNode){
        fireAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(fireArray, timePerFrame: 0.08))
        fireNode.runAction(fireAnimation)
    }
    
}