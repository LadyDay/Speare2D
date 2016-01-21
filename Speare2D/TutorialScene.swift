//
//  TutorialScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 21/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TutorialScene: SceneDefault {
    
    var clickChao = false
    var clickV2 = false
    var clickVelha = false

    var SpriteMao: SKSpriteNode!
    var SpriteMaoV: SKSpriteNode!
    var countDoorAnimation: Int = 0
    var doorArray = Array<SKTexture>()
    let doorAtlas = SKTextureAtlas(named: "portaCasa.atlas")
    
    var fireArray = Array<SKTexture>()
    let fireAtlas = SKTextureAtlas(named: "fogoCaldeira.atlas")
    var fireAnimation = SKAction()
    
    var oldieLadyArray = Array<SKTexture>()
    let oldieLadyAtlas = SKTextureAtlas(named: "idosaPiscando.atlas")
    var oldieAnimation = SKAction()
    
    var oldieLadyTalkingArray = Array<SKTexture>()
    let oldieLadyTalkingAtlas = SKTextureAtlas(named: "idosaFalando.atlas")
    var oldieTalkingAnimation = SKAction()
    
    var travellerMovingArray = Array<SKTexture>()
    let travellerMovingAtlas = SKTextureAtlas(named: "viajanteMovendo.atlas")
    var travellerMovingAnimation = SKAction()
    
    var travellerTalkingArray = Array<SKTexture>()
    let travellerTalkingAtlas = SKTextureAtlas(named: "viajanteFalando.atlas")
    var travellerTalkingAnimation = SKAction()
    
    var travellerArray = Array<SKTexture>()
    let travellerAtlas = SKTextureAtlas(named: "viajantePiscando.atlas")
    var travellerAnimation = SKAction()
    
    
    var ballon = UIView()//(frame: CGRectMake(0, 0, 187.25, 107.75))
    var ballonIsPresented: Bool = false
    static var ballonTraveller: Int = 0
    static var ballonOldie: Int = 1
    static var firstPresented = 0
    var imageBallon: UIImage!
    var imageViewBallon: UIImageView!
    var ballonIsPresentedCounter: Int!
    let exitButton = UIButton()
    let yesButton = UIButton()
    let noButton = UIButton()
    
    let clickCounter: Int = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.fileName = "TutorialScene"
        self.numberLevel = 0
        
        Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "currentScene", object: self.fileName)
        
        setCamera()
        setPositionCamera()
        initTextureFire()
        initFire(self.childNodeWithName("fire") as! SKSpriteNode)
        initArrayNPC()
        initNPC(self.childNodeWithName("velha")as! SKSpriteNode, travellerNode: self.childNodeWithName("viajante")as! SKSpriteNode)
        initClickTexture()
        initClickTextureLeft()
        initDoorTexture()
        
        addMaoViajante()
        addMaoVelha()
        tutorialTest()
        
        ballonIsPresentedCounter = 0
        if (TutorialScene.firstPresented == 0){
            TutorialScene.firstPresented = 1
            TutorialScene.ballonTraveller = 0
            TutorialScene.ballonOldie = 1
        }
        //musicBgConfiguration(fireTuto)
    }
    
    func initDoorTexture(){
        doorArray.append(doorAtlas.textureNamed("portaCasa1"))
        doorArray.append(doorAtlas.textureNamed("portaCasa2"))
        doorArray.append(doorAtlas.textureNamed("portaCasa3"))
        doorArray.append(doorAtlas.textureNamed("portaCasa2"))
        doorArray.append(doorAtlas.textureNamed("portaCasa1"))
    }
    func animationDoor(doorNode: SKSpriteNode){
        let doorAnimation = SKAction.repeatAction(SKAction.animateWithTextures(doorArray, timePerFrame: 0.1), count: 1)
        doorNode.runAction(doorAnimation)
    }

    func initTextureFire() {
        fireArray.append(fireAtlas.textureNamed("fogo1"))
        fireArray.append(fireAtlas.textureNamed("fogo2"))
    }
    
    func initFire(fireNode: SKSpriteNode){
        //let soundFire = SKAction.repeatActionForever(playSoundFileNamed(fireTuto, atVolume: SceneDefault.effectsVolume, waitForCompletion: true))
        fireAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(fireArray, timePerFrame: 0.08))
        //let group = SKAction.group([fireAnimation, soundFire])
        fireNode.runAction(fireAnimation)
        //fireNode.runAction(group, withKey: "actionFireSound")
        //self.musicBgConfiguration(fireTuto)
        
    }
    
    func initArrayNPC() {
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0006_piscando1_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0004_piscando3_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0004_piscando3_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0005_piscando2_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0004_piscando3_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0004_piscando3_360x476.png"))
        oldieLadyArray.append(oldieLadyAtlas.textureNamed("idosa_0006_piscando1_360x476.png"))
        oldieLadyTalkingArray.append(oldieLadyTalkingAtlas.textureNamed("idosa_0003_falando1_360x476.png"))
        oldieLadyTalkingArray.append(oldieLadyTalkingAtlas.textureNamed("idosa_0002_falando2_360x476.png"))
        oldieLadyTalkingArray.append(oldieLadyTalkingAtlas.textureNamed("idosa_0001_falando3_360x476.png"))
        travellerArray.append(travellerAtlas.textureNamed("viajante_piscada1_460x546.png"))
        travellerArray.append(travellerAtlas.textureNamed("viajante_piscada1_460x546.png"))
        travellerArray.append(travellerAtlas.textureNamed("viajante_piscada2_460x546.png"))
        travellerArray.append(travellerAtlas.textureNamed("viajante_piscada3_460x546.png"))
        travellerArray.append(travellerAtlas.textureNamed("viajante_piscada3_460x546.png"))
        travellerTalkingArray.append(travellerTalkingAtlas.textureNamed("viajantegalho_SPRITE_falando1.png"))
        travellerTalkingArray.append(travellerTalkingAtlas.textureNamed("viajantegalho_SPRITE_falando2.png"))
        travellerTalkingArray.append(travellerTalkingAtlas.textureNamed("viajantegalho_SPRITE_falando3.png"))
        travellerMovingArray.append(travellerMovingAtlas.textureNamed("viajantegalho_SPRITE1_480x548.png"))
        travellerMovingArray.append(travellerMovingAtlas.textureNamed("viajantegalho_SPRITE2_480x548.png"))
        travellerMovingArray.append(travellerMovingAtlas.textureNamed("viajantegalho_SPRITE3_480x548.png"))
        travellerMovingArray.append(travellerMovingAtlas.textureNamed("viajantegalho_SPRITE4_480x548.png"))
        travellerMovingArray.append(travellerMovingAtlas.textureNamed("viajantegalho_SPRITE5_480x548.png"))
    }
    
    func initNPC(oldieNode: SKSpriteNode, travellerNode: SKSpriteNode){
        oldieAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(oldieLadyArray, timePerFrame: 0.209))
        oldieNode.runAction(oldieAnimation)
        
        travellerAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(travellerArray, timePerFrame: 0.2))
        travellerNode.runAction(travellerAnimation)
    }
    
    func talkingNPC(NPC: SKSpriteNode) -> SKAction{
        if (NPC.name == "velha"){
            oldieTalkingAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(self.oldieLadyTalkingArray, timePerFrame: 0.1))
            return oldieTalkingAnimation
        } else /*if (NPC.name == "viajante")*/{
            travellerAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(self.travellerTalkingArray, timePerFrame: 0.1))
            return travellerAnimation
        }
    }
    
    func movingNPC(NPC: SKSpriteNode){
        if (NPC.name == "viajante"){
            travellerAnimation = SKAction.repeatAction(SKAction.animateWithTextures(self.travellerMovingArray, timePerFrame: 0.1), count: 3)
            NPC.runAction(travellerAnimation)
        }
    }
    
    
    
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if(self.touchRuning == false && theater.pauseMenuPresent == false && theater.flagStartTouchedBeganTheater == false && self.ballonIsPresented == false){
            self.touchRuning = true
            if let touch = touches.first {
                let location = touch.locationInNode(theater)
                
                //for nodeTouched in self.nodesAtPoint(location){
                let index = theater.nodesAtPoint(location).startIndex.advancedBy(1)
                if let nodeTouched: SKNode = theater.nodesAtPoint(location)[index] {
                    
                    switch nodeTouched.name!{
                        
                    case "cliqueChao":
                        
                        theater.removeVisionButtonsScene()
                        let sprite = nodeTouched as! SKSpriteNode
                        sprite.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                            sprite.removeFromParent()})
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            if let mao2 = self.theater.childNodeWithName("cliqueViajante") {
                                mao2.runAction(SKAction.fadeAlphaTo(1, duration: 0.5), completion: {
                                    mao2.hidden = false
                                    self.initClick(mao2 as! SKSpriteNode)
                                })}
                        })
                        
                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueChao", object: true)
                        
                        break
                        
                    case "cliqueViajante":
                        
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonTraveller = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonTraveller = dictionaryBallonTraveller["Viajante"] as! Int
                            }
                            self.showBallon(TutorialScene.ballonTraveller)
                            if (self.clickChao == true){
                                let mao = self.theater.childNodeWithName("cliqueViajante")
                                mao!.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                                    mao?.removeFromParent()
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueViajante", object: true)
                                })
                                let mao2 = self.theater.childNodeWithName("cliquePedras")
                                mao2?.hidden = false
                                self.initClick(mao2 as! SKSpriteNode)
                                self.theater.showVisionButtonsScene()
                            }
                            
                        })
                        
                        break
                        
                    case "viajante2":
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        let sprite = nodeTouched as! SKSpriteNode
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonTraveller = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonTraveller = dictionaryBallonTraveller["Viajante"] as! Int
                            }
                            self.showBallon(TutorialScene.ballonTraveller)
                        })
                        break
                        
                        
                    case "cliquePedras":
                        
                        theater.removeVisionButtonsScene()
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        
                        sprite.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                            //sprite.runAction(SKAction.fadeAlphaTo(1, duration: 0))
                            sprite.removeFromParent()
                        })
                        
                        let object = self.theater.nodesAtPoint(location)[theater.nodesAtPoint(location).startIndex.advancedBy(2)] as! SKSpriteNode
                        if(SKTexture.returnNameTexture(object.texture!) == "pedras"){
                            self.theater.catchObject(self.theater, location: location, object: self.theater.nodesAtPoint(location)[theater.nodesAtPoint(location).startIndex.advancedBy(2)])
                        }
                        
                        self.touchRuning = false
                        break
                        
                    case "hortaNode":
                        //changes the scene for the garden
                        self.removeAllActions()
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = FarmScene(fileNamed: "FarmScene")
                            self.theater.fileName = "FarmScene"
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
                        //changes the scene for the garden
                        self.removeAllActions()
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = KitchenScene(fileNamed: "KitchenScene")
                            self.theater.fileName = "KitchenScene"
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false, completion: {
                                self.theater!.mainCharacter.position.x = 167
                                if(self.theater!.mainCharacter.xScale<0){
                                    self.theater!.mainCharacter.xScale = self.theater!.mainCharacter.xScale * (-1)
                                }
                            })
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    case "viajante":
                        //changes the scene for the garden
                        
                        theater.removeVisionButtonsScene()
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonTraveller = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonTraveller = dictionaryBallonTraveller["Viajante"] as! Int
                            }
                            self.showBallon(TutorialScene.ballonTraveller)
                            if (self.clickChao == true){
                                if let mao = self.theater.childNodeWithName("cliqueViajante") {
                                    mao.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                                        mao.removeFromParent()
                                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueViajante", object: true)
                                    })
                                    if let mao2 = self.theater.childNodeWithName("cliquePedras") {
                                        mao2.hidden = false
                                        self.initClick(mao2 as! SKSpriteNode)
                                    }
                                }
                            }
                            
                            self.theater.showVisionButtonsScene()
                            
                        })
                        break
                        
                    case "velha":
                        
                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueVelha", object: true)
                        if let mao = self.theater.childNodeWithName("cliqueVelha") {
                            mao.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                                mao.removeFromParent()
                            })
                        }
                        
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            
                            //nodeTouched.runAction(self.talkingNPC(nodeTouched as! SKSpriteNode), withKey: "falando")
                            
                            self.showBallonOldie()
                            
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonOldie = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonOldie = dictionaryBallonOldie["Velha"] as! Int
                            }
                            
                            //
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    case "cliqueVelha":
                        
                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueVelha", object: true)
                        if let mao = self.theater.childNodeWithName("cliqueVelha") {
                            mao.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                                mao.removeFromParent()
                            })
                        }
                        
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            
                            //nodeTouched.runAction(self.talkingNPC(nodeTouched as! SKSpriteNode), withKey: "falando")
                            
                            self.showBallonOldie()
                            
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonOldie = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonOldie = dictionaryBallonOldie["Velha"] as! Int
                            }
                            
                            //
                            self.theater.showVisionButtonsScene()
                        })
                        break
                        
                    default:
                        if(theater.inventoryPresent==false && location.y<200){
                            //mainCharacter walks
                            theater.removeVisionButtonsScene()
                            theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                if let mao = self.theater.childNodeWithName("cliqueChao"){
                                    mao.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                                        mao.removeFromParent()
                                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueChao", object: true)})
                                    let mao2 = self.theater.childNodeWithName("cliqueViajante")
                                    mao2!.runAction(SKAction.fadeAlphaTo(1, duration: 1), completion: {
                                        mao2?.hidden = false
                                        self.initClick(mao2 as! SKSpriteNode)}
                                    )
                                    
                                }
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
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (clickV2){
            clickV2 = false
            if let mao = self.theater.childNodeWithName("viajante2"){
                mao.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                    mao.removeFromParent()})
            }
            
            if let mao2 = self.theater.childNodeWithName("cliqueVelha") {
                mao2.runAction(SKAction.fadeAlphaTo(1, duration: 0.5), completion: {
                    mao2.hidden = false
                    self.initClick2(mao2 as! SKSpriteNode)
                })
            }
        }
        
        if (self.theater.showViajante2 == true){
            self.theater.showViajante2 = false
            showTutoViajante2()
        }
        
        if(countDoorAnimation == 200){
            countDoorAnimation = 0
            if(!touchRuning){
                self.animationDoor(self.theater.childNodeWithName("casaNode") as! SKSpriteNode)
            }
        }else{
            countDoorAnimation++
        }
    }
    
    func tutorialTest(){
        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Tutorial"){
            let completedLevel = dictionary["completedLevel"] as! Bool
            let click = dictionary["cliqueChao"] as! Bool
            let click2 = dictionary["cliqueViajante"] as! Bool
            let click3 = dictionary["cliquePedras"] as! Bool
            //let click4 = dictionary["cliqueViajante"] as! Bool
            //let click5 = dictionary["cliquePedras"] as! Bool
            let click6 = dictionary["cliqueViajante2"] as! Bool
            let click7 = dictionary["cliqueVelha"] as! Bool
            if(!click){
                initClick(self.childNodeWithName("cliqueChao") as! SKSpriteNode)
                self.childNodeWithName("cliqueViajante")?.hidden = true
                self.childNodeWithName("cliquePedras")?.hidden = true
                //self.childNodeWithName("swipeDown")?.hidden = true
                //self.childNodeWithName("swipeUp")?.hidden = true
                self.childNodeWithName("viajante2")?.hidden = true
                self.childNodeWithName("cliqueVelha")?.hidden = true
            }else if (!click2){
                self.childNodeWithName("cliqueChao")?.removeFromParent()
                initClick(self.childNodeWithName("cliqueViajante") as! SKSpriteNode)
                self.childNodeWithName("cliquePedras")?.hidden = true
                //self.childNodeWithName("swipeDown")?.hidden = true
                //self.childNodeWithName("swipeUp")?.hidden = true
                self.childNodeWithName("viajante2")?.hidden = true
                self.childNodeWithName("cliqueVelha")?.hidden = true
            }else if  (!click3){
                self.childNodeWithName("cliqueChao")?.removeFromParent()
                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                initClick(self.childNodeWithName("cliquePedras") as! SKSpriteNode)
                //self.childNodeWithName("swipeDown")?.hidden = true
                //self.childNodeWithName("swipeUp")?.hidden = true
                self.childNodeWithName("viajante2")?.hidden = true
                self.childNodeWithName("cliqueVelha")?.hidden = true
                //            }else if  (!click4){
                //                self.childNodeWithName("cliqueChao")?.removeFromParent()
                //                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                //                self.childNodeWithName("cliquePedras")?.removeFromParent()
                //                initClick(self.childNodeWithName("swipeDown")as! SKSpriteNode)
                //                self.childNodeWithName("swipeUp")?.hidden = true
                //                self.childNodeWithName("viajante2")?.hidden = true
                //                self.childNodeWithName("cliqueVelha")?.hidden = true
                //            }else if  (!click5){
                //                self.childNodeWithName("cliqueChao")?.removeFromParent()
                //                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                //                self.childNodeWithName("cliquePedras")?.removeFromParent()
                //                self.childNodeWithName("swipeDown")?.removeFromParent()
                //                initClick(self.childNodeWithName("swipeUp")as! SKSpriteNode)
                //                self.childNodeWithName("viajante2")?.hidden = true
                //                self.childNodeWithName("cliqueVelha")?.hidden = true
            }else if  (!click6){
                self.childNodeWithName("cliqueChao")?.removeFromParent()
                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                self.childNodeWithName("cliquePedras")?.removeFromParent()
                //self.childNodeWithName("swipeDown")?.hidden = true
                //self.childNodeWithName("swipeUp")?.hidden = true
                self.childNodeWithName("cliqueVelha")?.hidden = true
                if (completedLevel){
                    initClick(self.childNodeWithName("viajante2") as! SKSpriteNode)
                } else {
                    let mao = self.childNodeWithName("viajante2") as! SKSpriteNode
                    mao.hidden = true
                }
            }else if  (!click7){
                self.childNodeWithName("cliqueChao")?.removeFromParent()
                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                self.childNodeWithName("cliquePedras")?.removeFromParent()
                //self.childNodeWithName("swipeDown")?.removeFromParent()
                //self.childNodeWithName("swipeUp")?.removeFromParent()
                self.childNodeWithName("viajante2")?.removeFromParent()
                initClick2(self.childNodeWithName("cliqueVelha") as! SKSpriteNode)
            }else{
                self.childNodeWithName("cliqueChao")?.removeFromParent()
                self.childNodeWithName("cliqueViajante")?.removeFromParent()
                self.childNodeWithName("cliquePedras")?.removeFromParent()
                //self.childNodeWithName("swipeDown")?.removeFromParent()
                //self.childNodeWithName("swipeUp")?.removeFromParent()
                self.childNodeWithName("viajante2")?.removeFromParent()
                self.childNodeWithName("cliqueVelha")?.removeFromParent()
            }
        }
    }
    
    func addMaoViajante(){
        //Mão problemática
        SpriteMao = SKSpriteNode(imageNamed: "clique1")
        SpriteMao.position = CGPointMake(861.068, 372.182)
        SpriteMao.zPosition = CGFloat(95)
        SpriteMao.name = "viajante2"
        
        self.addChild(SpriteMao)
    }
    
    func addMaoVelha(){
        //Mão problemática
        SpriteMaoV = SKSpriteNode(imageNamed: "cliqueE1")
        SpriteMaoV.position = CGPointMake(355.607, 321.569)
        SpriteMaoV.zPosition = CGFloat(95)
        SpriteMaoV.name = "cliqueVelha"
        
        self.addChild(SpriteMaoV)
    }
    
    func showTutoViajante2(){
        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Tutorial"){
            let completedLevel = dictionary["completedLevel"] as! Bool
            if (completedLevel){
                if let mao = self.theater.childNodeWithName("viajante2") {
                    mao.runAction(SKAction.fadeAlphaTo(1, duration: 0.5), completion: {
                        mao.hidden = false
                        self.initClick(mao as! SKSpriteNode)
                    })
                }
            }
        }
    }
    
    
    func setupBallonView(image: String){
        effectConfiguration(dialoguePopup, waitC: true)
        let imageBG = UIImage(named: image)
        let imageView = UIImageView(image: imageBG)
        //imageView.frame = CGRectMake(0, 0, 187.25, 107.75)
        
        ballonIsPresented = true
        ballon = UIView(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        if (TutorialScene.ballonTraveller == 3 ){
            ballon.center = CGPointMake(512.0, 384.0)
            
        } else {
            ballon.center = CGPointMake(512.0, 250.0) }
        ballon.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.0)
        
        self.view?.addSubview(ballon as UIView)
        
        ballon.addSubview(imageView)
        ballon.cheetah.scale(1).duration(0.5).run()
        
    }
    
    func setupButton(Button: UIButton, image: String, tag: Int, locationCenter: CGPoint){
        var buttonDemo = Button
        let imageBG = UIImage(named: image)
        let imageView = UIImageView(image: imageBG)
        
        buttonDemo = UIButton(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        buttonDemo.center = CGPointMake(locationCenter.x, locationCenter.y)
        //buttonDemo.backgroundColor = UIColor.blackColor()
        buttonDemo.setTitle("", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = tag
        buttonDemo.setImage(imageBG, forState: UIControlState.Normal)
        
        self.ballon.addSubview(buttonDemo)
        self.ballon.bringSubviewToFront(buttonDemo)
    }
    
    func buttonAction(sender:UIButton!)
    {
        //removeActionForKey("falando")
        
        switch sender.tag{
        case 30:
            ballonIsPresented = false
            print("Button tapped tag 30: exit")
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballon.removeFromSuperview()
            if let mao2 = self.theater.childNodeWithName("cliqueViajante"){
                mao2.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                    mao2.removeFromParent()})
                Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueViajante", object: true)
            }
            break
            
        case 31:
            //Escolheu ajudar o viajante
            ballonIsPresented = false
            self.clickChao = true
            print("Button tapped tag 31: Escolheu ajudar o viajante")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 1
            
            //salva o dado no arquivo
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(1, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            
            ballon.removeFromSuperview()
            break
            
        case 32:
            //Escolheu não ajudar o viajante
            ballonIsPresented = false
            self.clickChao =  false
            print("Button tapped tag 32: Escolheu NÃO ajudar o viajante")
            //effectConfiguration(metalEffectSound, waitC: true)
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            //TutorialScene.ballonTraveller = 0
            //ballonIsPresentedCounter = 0
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(0, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
        case 33:
            print("Button tapped tag 33: NÃO vamos dividir a sopa")
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = -1
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(-1, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
        case 34:
            print("Button tapped tag 34: quer ajudar")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 1
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(1, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
        case 35:
            print("Button tapped tag 35: VAMOS dividir a sopa")
            
            Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueViajante2", object: true)
            clickV2 = true
            
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 4
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(3, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
        case 36:
            print("Button tapped tag 36: TALVEZ vamos dividir a sopa")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 4
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(2, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
        case 37:
            print("Button tapped tag 37: Ainda NÃO quer dividir a sopa")
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 4
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(2, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            break
            
            
        case 50:
            print("Button tapped tag 30: exit")
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            ballon.removeFromSuperview()
            acabouBebe()
            break
            
        case 100:
            print("acabou")
            
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(3).run()
            ballonIsPresented = false
            TutorialScene.ballonOldie = 1
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(0, forKey: "Viajante")
                dict.setValue(0, forKey: "Velha")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            theater.transitionNextScene(self, sceneTransition: StartScene(fileNamed:"StartScene")!, withTheater: false)
            
            //limpar os arquivos
            Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Finished", object: NSArray())
            Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Inventory", object: NSDictionary())
            
            //            theater!.flagCurtinsClosed = true
            //            theater!.transitionSceneBackground(true)
            //            theater.curtains.runAction(SKAction.animateWithTextures(theater.animationCurtainsClosed, timePerFrame: 0.1))
            
            break
        default:
            break
        }
    }
    
    func showBallonOldie(){
        switch TutorialScene.ballonOldie{
        case 0:
            
            /*      Vamos ver se essa sopa vai ser boa...       */
            
            self.setupBallonView("vamos ver se essa sopa vai ser boa.png")
            self.setupButton(self.exitButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            //                                if (TutorialScene.ballonTraveller >= 2){
            //                                    TutorialScene.ballonOldie = 2
            //                                }
            
            break
            
            
        default:
            self.setupBallonView("nunca tomei uma sopa tao boa.png")
            self.setupButton(self.exitButton, image: "tela-de-pause-botaook.png", tag: 50, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            break
        }
        
    }
    
    
    func showBallon(valueInt: Int){
        
        switch TutorialScene.ballonTraveller{
            
        case 0:
            
            /*      Me ajuda a fazer a sopa?
            Sim ou Não?                 */
            
            self.setupBallonView("me ajuda a fazer a sopa.png")
            self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 31, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
            self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 32, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            break
            
        case 1:
            
            /*  Preciso de Pedras, Temperos e Legumes
            Ok                        */
            
            
            self.setupBallonView("preciso de tais coisas.png")
            self.setupButton(self.noButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            break
            
        case 2:
            
            
            /*      Vamos dividir com a velha?
            Sim ou Não?                 */
            self.setupBallonView("vamos-dividir-a-sopa-com-ela.png")
            self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 35, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
            self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 33, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            
            
            break
            
        case 3:
            /*      Decidiu dividir a sopa com a velha      */
            
            self.ballonIsPresented = false
            self.movingNPC(self.theater.childNodeWithName("viajante") as! SKSpriteNode)
            
            break
            
        default:
            /*      Tem certeza?           */
            self.setupBallonView("temctz.png")
            self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 37, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
            self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 36, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
            break
            
        }
        
    }
    
    func acabouBebe(){
        TutorialScene.ballonTraveller = 3
        setupBallonView("balao-de-parabens.png")
        ballonIsPresented = true
        self.touchRuning = false
        setupButton(exitButton, image: "botao-ok-parabens.png", tag: 100, locationCenter: CGPoint(x: (self.ballon.frame.width/2) - 5, y: self.ballon.frame.height-20))
        
    }
    
}