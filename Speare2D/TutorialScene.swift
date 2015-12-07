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
    static var ballonOldie: Int = 0
    static var firstPresented = 0
    var imageBallon: UIImage!
    var imageViewBallon: UIImageView!
    var ballonIsPresentedCounter: Int!
    let exitButton = UIButton()
    let yesButton = UIButton()
    let noButton = UIButton()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setCamera()
        setPositionCamera()
        initTextureFire()
        initFire(self.childNodeWithName("fire") as! SKSpriteNode)
        initArrayNPC()
        initNPC(self.childNodeWithName("velha")as! SKSpriteNode, travellerNode: self.childNodeWithName("viajante")as! SKSpriteNode)
        
        ballonIsPresentedCounter = 0
        //imageViewBallon.frame = CGRect(x: 0, y: 0, width: 187.25, height: 107.75)
        
        if (TutorialScene.firstPresented == 0){
            TutorialScene.firstPresented = 1
            TutorialScene.ballonTraveller = 0
            TutorialScene.ballonOldie = 0
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
                        
                    case "hortaNode":
                        //changes the scene for the garden
                        self.removeAllActions()
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.theater!.sceneBackground = FarmScene(fileNamed: "FarmScene")
                            self.theater.fileName = "FarmScene"
                            self.theater!.flagCurtinsClosed = true
                            self.theater!.transitionSceneBackground(false)
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
                            self.ballonIsPresented = true
                            //self.ballon.center = CGPointMake(512 - 1.5*(self.ballon.frame.width), (768/2) - 1.5*(self.ballon.frame.height))
                            
                            
                            switch TutorialScene.ballonTraveller{
                            case 0:
                                self.setupBallonView("me ajuda a fazer a sopa.png")
                                self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 31, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
                                self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 32, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))

                                
                                //sim ou nao
                                break
                            case 1:
                                //balao listando ingredientes
                                //informativo
                                

                                self.setupBallonView("preciso de tais coisas.png")
                                self.setupButton(self.noButton, image: "tela-de-pause-botaook.png", tag: 30, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                
                                
                                
                                break
//                            case 2:
//                                
//                                
//                                //balao quando todos os ingredientes foram entregues
//                                //a sopa ta pronta
//                                //informativo
//                                
//                                self.setupBallonView("tela de pause.png")
//                                self.setupButton(self.noButton, image: "Red_play_button.png", tag: 32, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
//                                
//                                
//                                break
                            case 2/*3*/:
                                // vamos dividir com a velha?
                                //sim ou nao
                                self.setupBallonView("vamos-dividir-a-sopa-com-ela.png")
                                self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 35, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
                                self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 33, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                
                                
                                break
                            default:
                                //mensagem padrao?
                                self.setupBallonView("temctz.png")
                                self.setupButton(self.yesButton, image: "tela-de-pause-botaosim.png", tag: 35, locationCenter: CGPoint(x: self.ballon.frame.width/6.5, y: self.ballon.frame.height-17))
                                self.setupButton(self.noButton, image: "tela-de-pause-botaonao.png", tag: 33, locationCenter: CGPoint(x: self.ballon.frame.width-101.6, y: self.ballon.frame.height-17))
                                break
                                
                            }
                            self.theater.showVisionButtonsScene()
                            
                        })
                        break
                        
                    case "velha":
                        theater.removeVisionButtonsScene()
                        theater!.mainCharacter.runAction(theater!.mainCharacter.walk(theater!.mainCharacter.position, touchLocation: location, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            self.touchRuning = false
                            self.ballonIsPresented = true
                            
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
        
        travellerTalkingArray.append(travellerAtlas.textureNamed("viajantegalho_SPRITE_falando1.png"))
        travellerTalkingArray.append(travellerAtlas.textureNamed("viajantegalho_SPRITE_falando2.png"))
        travellerTalkingArray.append(travellerAtlas.textureNamed("viajantegalho_SPRITE_falando3.png"))
        
    }
    
    func initNPC(oldieNode: SKSpriteNode, travellerNode: SKSpriteNode){
        oldieAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(oldieLadyArray, timePerFrame: 0.209))
        oldieNode.runAction(oldieAnimation)
        
        
        travellerAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(travellerArray, timePerFrame: 0.2))
        travellerNode.runAction(travellerAnimation)
        
    }
    
    
    func setupBallonView(image: String){
        effectConfiguration(dialoguePopup, waitC: true)
        let imageBG = UIImage(named: image)
        let imageView = UIImageView(image: imageBG)
        //imageView.frame = CGRectMake(0, 0, 187.25, 107.75)
        
        ballonIsPresented = true
        ballon = UIView(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        ballon.center = CGPointMake(512.0, 250.0)
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
        switch sender.tag{
        case 30:
            print("Button tapped tag 30: exit")
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            ballon.removeFromSuperview()
            break
        case 31:
            print("Button tapped tag 31: YEEEES")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            TutorialScene.ballonTraveller = 1
            ballon.removeFromSuperview()
            
            break
        case 32:
            print("Button tapped tag 32: NOOOO")
            //effectConfiguration(metalEffectSound, waitC: true)
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            TutorialScene.ballonTraveller = 0
            //ballonIsPresentedCounter = 0
            ballon.removeFromSuperview()
            break
        case 33:
            print("Button tapped tag 33: nao quis ajudar")
            effectConfiguration(vaia2, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            TutorialScene.ballonTraveller = -1
            ballon.removeFromSuperview()
            break
        case 34:
            print("Button tapped tag 34: quer ajudar")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            TutorialScene.ballonTraveller = 1
            ballon.removeFromSuperview()
            break
        case 35:
            print("Button tapped tag 35: quer dividir")
            effectConfiguration(applauseSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            TutorialScene.ballonTraveller = 4
            ballon.removeFromSuperview()
            break
        case 36:
            print("Button tapped tag 36: pegou chave")
            
            effectConfiguration(dialoguePopup, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            TutorialScene.ballonOldie = 1
            ballon.removeFromSuperview()
            break
        default:
            break
        }
    }
    
}