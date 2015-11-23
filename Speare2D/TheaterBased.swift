//
//  theaterBased.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 12/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class TheaterBased: SceneGameBase {
    
    let imageBackName = "paused.png"
    var pauseMenuPresent: Bool!
    var pauseMenuCounter = 0
    var pauseMenuView: SKView!
    let backButton = UIButton(frame: CGRectMake(0, 0, 177/2, 55/2))
    var iten: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addObjects()
        pauseMenuPresent = false
        
        mainCharacter.name = "Alex"
        
        //clear the inventory (textures and colors)
        self.inventory.firstFunc()
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(mainCharacter)
        
        let sceneBaseView = self.view!.superview! as! SKView
        self.camera = sceneBaseView.scene!.camera
        print("Touch: \(pauseMenuPresent)")
    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let sceneBaseView = self.view!.superview! as! SKView
        let sceneBase = sceneBaseView.scene!
        if(inventoryPresent==true){
            swipeUp()
        }
        
        //Selecting pause menu
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            if let nodeTouched: SKNode = self.nodeAtPoint(location){
                let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
                if(nodeTouched == saco && pauseMenuCounter == 0){
                    pauseMenuCounter++
                    effectConfiguration(selectionButtonSound, waitC: true)
                    pauseMenu()
                }
//                if(nodeTouched.name == nil){
//                    self.catchObject(self.theater, location: location, object: nodeTouched)
//                }
                
                //substitui essa chamada de metódo abaixo pela tua função
                sceneBase.touchesBegan(touches, withEvent: event)
            }
        }
        
        //sceneBase.touchesBegan(touches, withEvent: event)
        print("Touch: \(pauseMenuPresent)")
    }
    
    func addObjects(){
        let sceneBaseView = self.view!.superview! as! SKView
        for object in sceneBaseView.scene!.children{
            if (object.name != "background"){
                let objectInTheater = object
                object.removeFromParent()
                addChild(objectInTheater)
            }
        }
    }
    
    func updateButtonsScene(){
        let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
        saco.position.x = 50 + self.camera!.position.x - 512
        let corda = self.childNodeWithName("cordaInventario") as! SKSpriteNode
        corda.position.x = 1000 + self.camera!.position.x - 512
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateCameraSceneDefault()
        updateButtonsScene()
        if (inventoryPresent && SceneGameBase.itenComing){
            SceneGameBase.itenComing = false
            addItenFromInventory()
        }
    }
    
    
    func pauseMenu(){
//        pauseMenuView = SKView(frame: CGRectMake(0, 0, 480, 320))
//        setUpViews(pauseMenuView, /*originX: 0, originY: 0, sizeX: 480, sizeY: 320,*/ imageBGString: imageBackName, toBack: false)
        
        setupPauseView()
        setupBackButton(backButton)
        
    
    }
    
    func setupPauseView(){
        pauseMenuPresent = true
        pauseMenuView = SKView(frame: CGRectMake(0, 0, 240, 160))
        pauseMenuView.center = CGPointMake(512.0, 384.0)
        self.view?.addSubview(pauseMenuView as UIView)
        
        let imageBG = UIImage(named: imageBackName)
        let imageView = UIImageView(image: imageBG)
        imageView.frame = CGRectMake(0, 0, 240, 160)
        pauseMenuView.addSubview(imageView)
        pauseMenuView.cheetah.scale(3).duration(0.5).run()
        
    }
    
    func setupBackButton(Button: UIButton){
        let buttonDemo = Button
        buttonDemo.center = CGPointMake(120, 140)
        buttonDemo.backgroundColor = UIColor.blackColor()
        buttonDemo.setTitle("Voltar", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonBackAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = 21;
        buttonDemo.setImage(UIImage(named: "exitButton.png"), forState: UIControlState.Normal)
        self.pauseMenuView!.addSubview(buttonDemo)
        self.pauseMenuView.bringSubviewToFront(buttonDemo)
    }
    
    func buttonBackAction(sender:UIButton!)
    {
        //var btnsendtag:UIButton = sender
        if sender.tag == 21 {
            print("Button tapped tag 21")
            effectConfiguration(backButtonSound, waitC: true)
            //let fadeScene = SKTransition.fadeWithDuration(0.7)
            pauseMenuView.cheetah.scale(0.5).duration(2).run()
            //pauseMenuView.cheetah.wait()
            pauseMenuPresent = false
            pauseMenuCounter--
            pauseMenuView.removeFromSuperview()
        }
    }
    
    func addItenFromInventory(){
        iten = SceneGameBase.itenFromInventory
        iten.position = CGPoint(x: (self.camera?.position.x)!, y: 700)
        addChild(iten)
        iten.position = CGPoint(x: (self.camera?.position.x)!, y: 700)
        iten.name = nil
        iten.zPosition = 45
        fallingIten(iten)
        addObjects()

    }
    
    func fallingIten(obj: SKSpriteNode){
        let initA = SKAction.moveTo(CGPoint(x: iten.position.x, y: 1000), duration: 0.0)
        let fallingAction = SKAction.moveTo(CGPoint(x: iten.position.x, y: mainCharacter.position.y), duration: 1.0)
        let upOne = SKAction.moveTo(CGPoint(x: iten.position.x, y: mainCharacter.position.y + 20), duration: 0.2)
        let downOne = SKAction.moveTo(CGPoint(x: iten.position.x, y: mainCharacter.position.y), duration: 0.2)
        let upTwo = SKAction.moveTo(CGPoint(x: iten.position.x, y: mainCharacter.position.y + 10), duration: 0.2)
        let downTwo = SKAction.moveTo(CGPoint(x: iten.position.x, y: mainCharacter.position.y), duration: 0.2)
        let groupAction = SKAction.sequence([initA, fallingAction, upOne, downOne, upTwo, downTwo])
        obj.runAction(groupAction)
        obj.position = CGPoint(x: (self.camera?.position.x)!, y: mainCharacter.position.y)
    }
}
