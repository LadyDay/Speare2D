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
    var ballon = SKView()//(frame: CGRectMake(0, 0, 187.25, 107.75))
    var ballonIsPresented: Bool = false
    var ballonTraveller: Int = 0
    var ballonOldie: Int = 0
    var firstPresented = 0
    var imageBallon: UIImage!
    var imageViewBallon: UIImageView!
    var ballonIsPresentedCounter: Int!
    let exitButton = UIButton(frame: CGRectMake(0, 0, 177/2, 55/2))
    let yesButton = UIButton(frame: CGRectMake(0, 0, 177/2, 55/2))
    let noButton = UIButton(frame: CGRectMake(0, 0, 177/2, 55/2))
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setCamera()
        setPositionCamera()
        initTextureFire()
        initFire(self.childNodeWithName("fire") as! SKSpriteNode)
        
        ballonIsPresentedCounter = 0
        //imageViewBallon.frame = CGRect(x: 0, y: 0, width: 187.25, height: 107.75)
        
        if (firstPresented == 0){
            firstPresented = 1
            ballonTraveller = 0
            ballonOldie = 0
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
                            
                            
                            switch self.ballonTraveller{
                            case 0:
                                self.setupBallonView("me ajuda a fazer a sopa.png")
                                self.setupButton(self.yesButton, image: "tela-de-pausa-botaosim.png", tag: 31, locationCenter: CGPoint(x: self.ballon.frame.width/3, y: 2*self.ballon.frame.height/3))
                                self.setupButton(self.noButton, image: "tela-de-pausa-botaosim.png", tag: 32, locationCenter: CGPoint(x: 2*self.ballon.frame.width/3, y: 2*self.ballon.frame.height/3))

                                
                                //sim ou nao
                                break
                            case 1:
                                //balao listando ingredientes
                                //informativo
                                

                                self.setupBallonView("tela de pause.png")
                                self.setupButton(self.noButton, image: "Red_play_button.png", tag: 32, locationCenter: CGPoint(x: 2*self.ballon.frame.width/3, y: 2*self.ballon.frame.height/3))
                                
                                
                                
                                break
                            case 2:
                                //balao quando todos os ingredientes foram entregues
                                //a sopa ta pronta
                                //informativo
                                
                                self.setupBallonView("tela de pause.png")
                                self.setupButton(self.noButton, image: "Red_play_button.png", tag: 32, locationCenter: CGPoint(x: 2*self.ballon.frame.width/3, y: 2*self.ballon.frame.height/3))
                                
                                
                                break
                            case 3:
                                // vamos dividir com a velha?
                                //sim ou nao
                                //self.imageBallon = UIImage(named: "imageBackName")
                                //self.imageViewBallon = UIImageView(image: self.imageBallon)
                                
                                
                                break
                            default:
                                //mensagem padrao?
                                //self.imageBallon = UIImage(named: "imageBackName")
                                //self.imageViewBallon = UIImageView(image: self.imageBallon)
                                //imageViewBallon.frame = CGRectMake(0, 0, 187.25, 107.75)
                                break
                                
                            }
                            self.theater.showVisionButtonsScene()
                            
                        })
                        break
                        
                    case "velha":
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
        //let soundFire = SKAction.repeatActionForever(playSoundFileNamed(fireTuto, atVolume: SceneDefault.effectsVolume, waitForCompletion: true))
        fireAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(fireArray, timePerFrame: 0.08))
        //let group = SKAction.group([fireAnimation, soundFire])
        fireNode.runAction(fireAnimation)
        //fireNode.runAction(group, withKey: "actionFireSound")
        //self.musicBgConfiguration(fireTuto)
        
    }
    
    func setupBallonView(image: String){
        effectConfiguration(dialoguePopup, waitC: true)
        let imageBG = UIImage(named: image)
        let imageView = UIImageView(image: imageBG)
        //imageView.frame = CGRectMake(0, 0, 187.25, 107.75)
        
        ballonIsPresented = true
        ballon = SKView(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        ballon.center = CGPointMake(512.0, 384.0)
        self.view?.addSubview(ballon as UIView)
        
        ballon.addSubview(imageView)
        ballon.cheetah.scale(1).duration(0.5).run()
        
    }
    
    func setupButton(Button: UIButton, image: String, tag: Int, locationCenter: CGPoint){
        let buttonDemo = Button
        buttonDemo.center = CGPointMake(locationCenter.x, locationCenter.y)
        buttonDemo.backgroundColor = UIColor.clearColor()
        buttonDemo.setTitle("", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = tag
        buttonDemo.setImage(UIImage(named: image), forState: UIControlState.Normal)
        self.ballon.addSubview(buttonDemo)
        self.ballon.bringSubviewToFront(buttonDemo)
    }
    
    func buttonAction(sender:UIButton!)
    {
        switch sender.tag{
        case 30:
            print("Button tapped tag 30: exit")
            effectConfiguration(backButtonSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            ballon.removeFromSuperview()
            break
        case 31:
            print("Button tapped tag 31: YEEEES")
            effectConfiguration(backButtonSound, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            //ballonIsPresentedCounter = 0
            ballonTraveller++
            ballon.removeFromSuperview()
            
            break
        case 32:
            print("Button tapped tag 32: NOOOO")
            effectConfiguration(backButtonSound, waitC: true)
            effectConfiguration(vaia, waitC: true)
            ballon.cheetah.scale(0.5).duration(2).run()
            ballonIsPresented = false
            ballonTraveller = 0
            //ballonIsPresentedCounter = 0
            ballon.removeFromSuperview()
            break
        default:
            break
        }
    }
    
}