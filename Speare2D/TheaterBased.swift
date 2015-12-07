//
//  theaterBased.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 12/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//  COORDENADAS: Y = ((y-214)/2)-768 e X = x/2
//

import SpriteKit

class TheaterBased: SceneGameBase {
    
    //flags
    var flagStartTouchedBeganTheater: Bool!
    //
    var saco: SKSpriteNode!
    var corda: SKSpriteNode!
    var sceneBackground: SceneDefault!
    var flagCurtinsClosed: Bool = false
    let imageBackName = "tela-de-pause-sembotao.png"
    let imageExitButton = "tela-de-pause-botaomenu.png"
    let imageReturnButton = "tela-de-pause-botaovoltar.png"
    var pauseMenuPresent: Bool!
    var pauseMenuCounter = 0
    var pauseMenuView: SKView!
    let returnButton = UIButton()//(frame: CGRectMake(0, 0, 177/2, 55/2))
    let exitButton = UIButton()//(frame: CGRectMake(0, 0, 177/2, 55/2))
    var iten: SKSpriteNode!
    var itenHasMoved: Bool = false
    var selectedNode: SKNode!
    var selectedNodeZPosition: CGFloat!
    var animationCurtainsOpen = Array<SKTexture>()
    var animationCurtainsClosed = Array<SKTexture>()
    var curtains: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
        self.corda = self.childNodeWithName("cordaInventario") as! SKSpriteNode
        self.curtains = self.childNodeWithName("cortinaLateral") as! SKSpriteNode
        
        //init sprites da cortina
        for(var j = 1; j < 11; j++){
            animationCurtainsClosed.append(SKTexture(imageNamed: "cortinaFechando" + String(j)))
        }
        
        for(var j = 10; j>0; j--){
            animationCurtainsOpen.append(SKTexture(imageNamed: "cortinaFechando" + String(j)))
        }
        
        
        flagCurtinsClosed = true
        transitionSceneBackground(true)
        pauseMenuPresent = false
        
        mainCharacter.name = "Alex"
        
        //clear the inventory (textures and colors)
        self.inventory.firstFunc(self)
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        addChild(mainCharacter)
        
        print("Touch: \(pauseMenuPresent)")
    }
    
    func transitionSceneBackground(backgroundBlack: Bool){
        
        if(inventoryPresent==true){
            swipeUp()
        }
        self.removeVisionButtonsScene()
        
        curtains.runAction(SKAction.animateWithTextures(animationCurtainsClosed, timePerFrame: 0.1), completion: {
            self.removeObjects({
                Dictionary<String, AnyObject>.saveGameData("StateGame", key: "currentScene", object: self.fileName)
                self.sceneBackground.touchRuning = false
                let sceneBaseView = self.view!.superview! as! SKView
                self.sceneBackground.theater = self
                sceneBaseView.presentScene(self.sceneBackground)
                self.mainCharacter.offsetAlexWalk = self.sceneBackground.offsetWalkScene
                self.camera = self.sceneBackground.camera
                //self.removeFromParent()
                //self.sceneBackground.backgroundMusic.removeFromParent()
                self.addObjects()
                self.curtains.runAction(SKAction.animateWithTextures(self.animationCurtainsOpen, timePerFrame: 0.1), completion: {
                    self.flagCurtinsClosed = false
                    self.showVisionButtonsScene()
                })
            })
        })
    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        self.flagStartTouchedBeganTheater = true
        
        let sceneBaseView = self.view!.superview! as! SKView
        let sceneBase = sceneBaseView.scene!
        
        if(inventoryPresent==true){
            swipeUp()
        }
        
        //Selecting pause menu
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
            var nodeTouched: SKNode = self.nodeAtPoint(location)
            if(nodeTouched == saco && pauseMenuCounter == 0){
                pauseMenuCounter++
                flagCurtinsClosed = true
                curtains.runAction(SKAction.animateWithTextures(animationCurtainsClosed, timePerFrame: 0.1))
                removeVisionButtonsScene()
                effectConfiguration(selectionButtonSound, waitC: true)
                pauseMenu()
            } else {
                let index = self.nodesAtPoint(location).startIndex.advancedBy(1)
                if let nodeTouched: SKNode = self.nodesAtPoint(location)[index] {
                    if(nodeTouched.name == nil){
                        itenHasMoved = false
                        selectedNode = nodeTouched as! SKSpriteNode
                        selectedNodeZPosition = selectedNode.zPosition
                    }
                }
            }
        }
        print("Touch: \(pauseMenuPresent)")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.locationInNode(self)
            let previousPosition = touch.previousLocationInNode(self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            itenHasMoved = true
            if(selectedNode != nil){
                selectedNode.zPosition = 98
                self.panForTranslation(translation)
            }
            /*
            let index = self.nodesAtPoint(positionInScene).startIndex.advancedBy(1)
            if let nodeTouched: SKSpriteNode = self.nodesAtPoint(positionInScene)[index] as? SKSpriteNode{
                if(nodeTouched == selectedNode){
                    itenHasMoved = true
                    //selectedNode = nodeTouched as! SKSpriteNode
                    self.panForTranslation(translation)
                }
            }
    */
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let sceneBaseView = self.view!.superview! as! SKView
        let sceneBase = sceneBaseView.scene!
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let index = self.nodesAtPoint(location).startIndex.advancedBy(1)
            let nodeTouched = self.nodesAtPoint(location)[index] as! SKSpriteNode
            
            if(nodeTouched.name == nil && itenHasMoved == false){
                self.catchObject(self, location: location, object: nodeTouched)
            }else if (nodeTouched.name == nil && itenHasMoved == true) {
                itenHasMoved = false
                //Quando soltar o item que estava sendo movido:
                var interactionPossible: Bool = false
                for nodes in self.nodesAtPoint(location){
                    if nodes.name != nil{
                        if self.objectsInteraction(nodes as! SKSpriteNode, receivedObject: nodeTouched) != nil {
                            if(interactionPossible == false){
                                interactionPossible = self.objectsInteraction(nodes as! SKSpriteNode, receivedObject: nodeTouched)!
                            }
                        }
                    }
                }
                
                if(interactionPossible){
                    //animação do objeto
                    //sceneBased.
                    if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("TutorialScene") {
                        let indexDataScene = dictionaryDataScene.indexForKey("Finished")
                        let arrayFinished = dictionaryDataScene[indexDataScene!].1 as! NSArray
                        var array = NSMutableArray(array: arrayFinished)
                        array.addObject(SKTexture.returnNameTexture(nodeTouched.texture!))
                        
                        Dictionary<String, AnyObject>.saveGameData("TutorialScene", key: "Finished", object: array as NSArray)
                    }
                    nodeTouched.removeFromParent()
                }else{
                    selectedNode.zPosition = selectedNodeZPosition
                    fallingIten(selectedNode as! SKSpriteNode, fromInventory: false)
                    selectedNode = nil
                }
                
            }else if (nodeTouched.name != nil){
                self.flagStartTouchedBeganTheater = false
                sceneBase.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    func objectsInteraction(fixedObject: SKSpriteNode, receivedObject: SKSpriteNode) -> Bool? {
        let nameFixedObject = SKTexture.returnNameTexture(fixedObject.texture!)
        let nameReceivedObject = SKTexture.returnNameTexture(receivedObject.texture!)
        if let dictionary = Dictionary<String, AnyObject>.loadGameData("TutorialScene") {
            if let index = dictionary.indexForKey(nameFixedObject) {
                if let array: NSArray = dictionary[index].1 as! NSArray{
                    for nameObject in array{
                        if(nameObject as! String == nameReceivedObject){
                            return true
                        }
                    }
                    return false
                }else{
                    return false
                }
            }else{
                return false
            }
        }else{
            return nil
        }
    }
    
    func selectNodeForTouch(touchLocation : CGPoint) {
        // 1
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            // 2
            if (!selectedNode.isEqual(touchedNode)) {
                selectedNode.removeAllActions()
                selectedNode.runAction(SKAction.rotateToAngle(0.0, duration: 0.1))
                
                selectedNode = touchedNode as! SKSpriteNode
                
                // 3
                let sequence = SKAction.sequence([SKAction.rotateByAngle(degToRad(-4.0), duration: 0.1),
                    SKAction.rotateByAngle(0.0, duration: 0.1),
                    SKAction.rotateByAngle(degToRad(4.0), duration: 0.1)])
                selectedNode.runAction(SKAction.repeatActionForever(sequence))
                
            }
        }
    }
    
    func panForTranslation(translation : CGPoint) {
        let position = selectedNode.position
        //
        //        if selectedNode.name! == nil {
        selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        //        }
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(degree / 180.0 * M_PI)
    }
    
    func addObjects(){
        for object in sceneBackground.children{
            if(object.name == nil && !object.isKindOfClass(SKAudioNode)){
                let string = SKTexture.returnNameTexture((object as! SKSpriteNode).texture!)
                if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("TutorialScene") {
                    let indexDataScene = dictionaryDataScene.indexForKey("Finished")
                    let array = dictionaryDataScene[indexDataScene!].1 as! NSArray
                    if !(array.containsObject(string)) {
                        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Inventory") {
                            if let index = dictionary.indexForKey(string) {
                                let dict = dictionary[index].1 as! Bool
                                if(dict){
                                    object.removeFromParent()
                                }else{
                                    print(object.name)
                                    let objectInTheater = object
                                    object.removeFromParent()
                                    addChild(objectInTheater)
                                }
                            }else{
                                //o objeto nunca entrou no inventario
                                print(object.name)
                                let objectInTheater = object
                                object.removeFromParent()
                                addChild(objectInTheater)
                            }
                        }
                    }else{
                        //o objeto já cumpriu sua função
                        //não vai aparecer nunca mais o/
                    }
                }
            }else{
                if(object.name! != "background" && object.name! != "camera"){
                    print(object.name)
                    let objectInTheater = object
                    object.removeFromParent()
                    addChild(objectInTheater)
                }
            }
        }
        print("=========")
    }

    func removeObjects(completion: () -> Void){
        for object in self.scene!.children{
            nopeObjectTheater(object)
        }
        completion()
    }
    
    private func nopeObjectTheater(object: SKNode){
        if(object.name != nil){
            switch object.name!{
            case "corSeletiva":
                break
                
            case "cortinaLateral":
                break
                
            case "cortina":
                break
                
            case "publico":
                break
                
            case "fundo":
                break
                
            case "sacoOpcao":
                break
                
            case "cordaInventario":
                break
                
            default:
                object.removeFromParent()
                break
                
            }
        }else{
                object.removeFromParent()
        }
    }
    
    func removeVisionButtonsScene(){
        saco.runAction(SKAction.moveToY(846.5, duration: 0.5))
        corda.runAction(SKAction.moveToY(835, duration: 0.5))
    }
    
    func showVisionButtonsScene(){
        saco.runAction(SKAction.moveToY(646.5, duration: 0.5))
        corda.runAction(SKAction.moveToY(635, duration: 0.5))
    }
    
    func updateButtonsScene(){
        saco.position.x = 56 + self.camera!.position.x - 512
        corda.position.x = 1000 + self.camera!.position.x - 512
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateCameraSceneDefault()
        if(!flagCurtinsClosed){
            updateButtonsScene()
            if (inventoryPresent && SceneGameBase.itenComing){
                SceneGameBase.itenComing = false
                addItenFromInventory()
            }
        }
    }
    
    
    func pauseMenu(){
        //        pauseMenuView = SKView(frame: CGRectMake(0, 0, 480, 320))
        //        setUpViews(pauseMenuView, /*originX: 0, originY: 0, sizeX: 480, sizeY: 320,*/ imageBGString: imageBackName, toBack: false)
        
        setupPauseView()
        setupButton(returnButton, imageBk: imageReturnButton, tag: 21, locationCenter: CGPoint(x: pauseMenuView.frame.width/2, y: 3*pauseMenuView.frame.height/6))
        setupButton(exitButton, imageBk: imageExitButton, tag: 20, locationCenter: CGPoint(x: pauseMenuView.frame.width/2, y: 4.5*pauseMenuView.frame.height/6))
        
        
        
    }
    
    func setupPauseView(){
        let imageBG = UIImage(named: imageBackName)
        let imageView = UIImageView(image: imageBG)
        
        pauseMenuPresent = true
        pauseMenuView = SKView(frame: CGRectMake(0, 0,imageView.frame.width, imageView.frame.height))
        pauseMenuView.center = CGPointMake(512.0, 384.0)
        self.view?.addSubview(pauseMenuView as UIView)
        
//        let imageBG = UIImage(named: imageBackName)
//        let imageView = UIImageView(image: imageBG)
        //imageView.frame = CGRectMake(0, 0, 187.25, 107.75)
        pauseMenuView.addSubview(imageView)
        pauseMenuView.cheetah.scale(1).duration(0.5).run()
        
    }
    
    func setupButton(Button: UIButton, imageBk: String, tag: Int, locationCenter: CGPoint){
        var buttonDemo = Button
        let imageBG = UIImage(named: imageBk)
        let imageView = UIImageView(image: imageBG)
        
        buttonDemo = UIButton(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        buttonDemo.center = CGPointMake(locationCenter.x, locationCenter.y)
        buttonDemo.backgroundColor = UIColor.clearColor()
        buttonDemo.setTitle("", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = tag
        buttonDemo.setImage(UIImage(named: imageBk), forState: UIControlState.Normal)
        //buttonDemo.highlighted = true
        
        self.pauseMenuView!.addSubview(buttonDemo)
        self.pauseMenuView.bringSubviewToFront(buttonDemo)
    }
    
    func buttonAction(sender:UIButton!)
    {
        switch sender.tag{
        case 20:
            print("Button tapped tag 20: exit")
            effectConfiguration(backButtonSound, waitC: true)
            pauseMenuView.cheetah.scale(0.5).duration(2).run()
            pauseMenuPresent = false
            pauseMenuCounter--
        
            pauseMenuView.removeFromSuperview()
            //TutorialScene.removeAllActions()
            //self.sceneBackground.removeFromParent()
            self.transitionNextScene(self.sceneBackground, sceneTransition: StartScene(fileNamed:"StartScene")!, withTheater: false)
            break
            
        case 21:
            print("Button tapped tag 21: return")
            effectConfiguration(backButtonSound, waitC: true)
            //let fadeScene = SKTransition.fadeWithDuration(0.7)
            pauseMenuView.cheetah.scale(0.5).duration(2).run()
            //pauseMenuView.cheetah.wait()
            pauseMenuPresent = false
            pauseMenuCounter--
            flagCurtinsClosed = false
            curtains.runAction(SKAction.animateWithTextures(animationCurtainsOpen, timePerFrame: 0.1))
            pauseMenuView.removeFromSuperview()
            self.showVisionButtonsScene()
            
            break
        default:
            break
        }
    }
    
    func addItenFromInventory(){
        iten = SceneGameBase.itenFromInventory
        iten.position = CGPoint(x: (self.camera?.position.x)!, y: 700)
        addChild(iten)
        iten.position = CGPoint(x: (self.camera?.position.x)!, y: 700)
        iten.name = nil
        //iten.zPosition = 50
        fallingIten(iten, fromInventory: true)
        //addObjects()
        
    }
    
    func fallingIten(obj: SKSpriteNode, fromInventory: Bool){
        obj.anchorPoint = CGPoint(x: 0.5, y: 0)
        let floorPosition = CGFloat(125)
        var initA = SKAction.moveTo(CGPoint(x: obj.position.x, y: obj.position.y), duration: 0.0)
        var secondsFalling = 0.4
        if (fromInventory){
            initA = SKAction.moveTo(CGPoint(x: obj.position.x, y: 1000), duration: 0.0)
            secondsFalling = 1.0
        }
        let fallingAction = SKAction.moveTo(CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/), duration: secondsFalling)
        let upOne = SKAction.moveTo(CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/ + 20), duration: 0.2)
        let downOne = SKAction.moveTo(CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/), duration: 0.2)
        let upTwo = SKAction.moveTo(CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/ + 10), duration: 0.2)
        let downTwo = SKAction.moveTo(CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/), duration: 0.2)
        let groupAction = SKAction.sequence([initA, fallingAction, upOne, downOne, upTwo, downTwo])
        obj.runAction(groupAction)
        obj.position = CGPoint(x: obj.position.x, y: floorPosition/*mainCharacter.position.y*/)
    }
}
