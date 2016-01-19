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
    
    var fireArray = Array<SKTexture>()
    let fireAtlas = SKTextureAtlas(named: "fogoCaldeira.atlas")
    var fireAnimation = SKAction()
    
    var oldieLadyArray = Array<SKTexture>()
    let oldieLadyAtlas = SKTextureAtlas(named: "idosaPiscando.atlas")
    var oldieAnimation = SKAction()
    
    var oldieLadyTalkingArray = Array<SKTexture>()
    let oldieLadyTalkingAtlas = SKTextureAtlas(named: "idosaFalando.atlas")
    var oldieTalkingAnimation = SKAction()
    
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
        
        if (clickChao == false){
            clickChao = true
            initClick(self.childNodeWithName("clique") as! SKSpriteNode)
        } else {
            self.childNodeWithName("clique")?.removeFromParent()
        }
        
        self.childNodeWithName("cliqueViajante")?.hidden = true
        self.childNodeWithName("cliqueChao")?.hidden = true
        
        ballonIsPresentedCounter = 0
        if (TutorialScene.firstPresented == 0){
            TutorialScene.firstPresented = 1
            TutorialScene.ballonTraveller = 0
            TutorialScene.ballonOldie = 1
        }
        //musicBgConfiguration(fireTuto)
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
                        
                    case "clique":
                        
                        theater.removeVisionButtonsScene()
                        
                        let sprite = nodeTouched as! SKSpriteNode
                        sprite.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                            //sprite.runAction(SKAction.fadeAlphaTo(1, duration: 0))
                            sprite.removeFromParent()
                        })
                        
                        
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            let mao2 = self.theater.childNodeWithName("cliqueViajante")
                            mao2!.runAction(SKAction.fadeAlphaTo(1, duration: 0.5), completion: {
                                mao2?.hidden = false})
                            self.initClick(mao2 as! SKSpriteNode)
                            
                            
                            
                            //initClick(self.childNodeWithName("cliqueViajante") as! SKSpriteNode)
                            //se não:
                            //self.childNodeWithName("clique")?.removeFromParent()


                            })
                        break
                        
                    case "cliqueViajante":
                        
                        //changes the scene for the garden
                        theater.removeVisionButtonsScene()
                        let mao = self.theater.childNodeWithName("cliqueViajante")
                        mao!.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                            mao?.removeFromParent()
                            let mao2 = self.theater.childNodeWithName("cliqueChao")
                            mao2?.hidden = false})
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
                            self.theater.showVisionButtonsScene()
                            
                        })
                        
                    break
                        
                        
                    case "clique2":
                        
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
                        
                        let mao = self.theater.childNodeWithName("cliqueViajante")
                        mao!.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                            mao?.removeFromParent()
                            let mao2 = self.theater.childNodeWithName("cliqueChao")
                            mao2?.hidden = false})
                        
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
                            
                            
                            self.theater.showVisionButtonsScene()
                            
                        })
                        break
                        
                    case "velha":
                        let sprite = nodeTouched as! SKSpriteNode
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: true, objectSize: sprite.size), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            
                            //nodeTouched.runAction(self.talkingNPC(nodeTouched as! SKSpriteNode), withKey: "falando")
                            
                            //lê informação do arquivo
                            if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                let dictionaryBallonOldie = dictionary["Characters"] as! NSDictionary
                                TutorialScene.ballonOldie = dictionaryBallonOldie["Velha"] as! Int
                            }
                            
                            switch TutorialScene.ballonOldie{
                            case 0:
                                
                                
                                self.setupBallonView("tome essa chave.png")
                                self.setupButton(self.exitButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                
                                //FUNCAO PARA A CHAVE CAIR/APARECER
                                //AQUI
                                //SE MAINCHARACTER PEGOU CHAVE{
                                TutorialScene.ballonOldie = 1
                                //}
                                break
                                
                            case 1:
                                
                                /*      Vamos ver se essa sopa vai ser boa...       */
                                
                                self.setupBallonView("vamos ver se essa sopa vai ser boa.png")
                                self.setupButton(self.exitButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                if (TutorialScene.ballonTraveller >= 2){
                                    TutorialScene.ballonOldie = 2
                                }
                               
                                break
                                
                            default:
                                self.setupBallonView("nunca tomei uma sopa tao boa.png")
                                self.setupButton(self.exitButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                break
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
                                if let mao = self.theater.childNodeWithName("clique"){
                                    mao.runAction(SKAction.fadeAlphaTo(0, duration: 1), completion: {
                                        mao.removeFromParent()})
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
            print("Button tapped tag 30: exit")
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            ballon.removeFromSuperview()
            break
            
        case 31:
            //Escolheu ajudar o viajante
            print("Button tapped tag 31: Escolheu ajudar o viajante")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
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
            //Escolheu ajudar o viajante
            print("Button tapped tag 32: Escolheu NÃO ajudar o viajante")
            //effectConfiguration(metalEffectSound, waitC: true)
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
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
            print("Button tapped tag 33: nao quis ajudar")
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
            print("Button tapped tag 35: quer dividir")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            //TutorialScene.ballonTraveller = 4
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(4, forKey: "Viajante")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
            acabouBebe()
            self.touchRuning = true
            break
            
        case 36:
            print("Button tapped tag 36: pegou chave")
            
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //TutorialScene.ballonOldie = 1
            if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                dict.setValue(1, forKey: "Velha")
                
                Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
            }
            ballon.removeFromSuperview()
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
                dict.setValue(1, forKey: "Velha")
                
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
        default:
            /*      Tem certeza?           */
            
            self.setupBallonView("temctz.png")
            self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 35, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
            self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 33, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
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
    
    override func update(currentTime: CFTimeInterval) {
    
        //verificador de cliques
        
    }
    
    
}