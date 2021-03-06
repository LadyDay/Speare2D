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
    
    //
    var eCenoura: Bool = false
    var saco: SKSpriteNode!
    var corda: SKSpriteNode!
    var sceneBackground: SceneDefault!
    var flagCurtinsClosed: Bool = false
    var showViajante2: Bool = false
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
    
    var swipeDownArray = Array<SKTexture>()
    let swipeDownAtlas = SKTextureAtlas(named: "arrastandobaixo.atlas")
    var swipeAnimation = SKAction()
    var swipeUpArray = Array<SKTexture>()
    let swipeUpAtlas = SKTextureAtlas(named: "arrastandocima.atlas")
    var swipeDSprite: SKSpriteNode!
    var swipeUSprite: SKSpriteNode!
    //var swipeUpAnimation = SKAction()
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        sceneBackground.userInteractionEnabled = false
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
        transitionSceneBackground(true, completion: {})
        pauseMenuPresent = false
        
        mainCharacter.name = "Alex"
        
        //clear the inventory (textures and colors)
        self.inventory.firstFunc(self)
        
        //Add swipes
        self.addSwipes(self.view!)
        
        //call function setupAlex
        self.mainCharacter.setupAlex()
        self.addChild(mainCharacter)
        
        self.flagStartTouchedBeganTheater = false
        
        print("Touch: \(pauseMenuPresent)")
        
        initSwipesTexture()
    }
    
    func setupSwipe(Down: Bool){
        if (Down){
            swipeDSprite = SKSpriteNode(imageNamed: "arrastar_baixo1")
            swipeDSprite.position = CGPointMake(1000 + self.camera!.position.x - 512, 635)
            swipeDSprite.zPosition = CGFloat(103)
            swipeDSprite.name = "swipeDownTutorial"
            
            self.addChild(swipeDSprite)
        } else {
            swipeUSprite = SKSpriteNode(imageNamed: "arrastar_cima1")
            swipeUSprite.position = CGPointMake(1000 + self.camera!.position.x - 512, 635)
            swipeUSprite.zPosition = CGFloat(103)
            swipeUSprite.name = "swipeUpTutorial"
            
            self.addChild(swipeUSprite)
        }

    }
    
    func initSwipesTexture(){
        swipeDownArray.append(swipeDownAtlas.textureNamed("arrastar_baixo1"))
        swipeDownArray.append(swipeDownAtlas.textureNamed("arrastar_baixo2"))
        swipeDownArray.append(swipeDownAtlas.textureNamed("arrastar_baixo3"))
        swipeDownArray.append(swipeDownAtlas.textureNamed("arrastar_baixo4"))
        swipeDownArray.append(swipeDownAtlas.textureNamed("arrastar_baixo5"))
        
        swipeUpArray.append(swipeUpAtlas.textureNamed("arrastar_cima1"))
        swipeUpArray.append(swipeUpAtlas.textureNamed("arrastar_cima2"))
        swipeUpArray.append(swipeUpAtlas.textureNamed("arrastar_cima3"))
        swipeUpArray.append(swipeUpAtlas.textureNamed("arrastar_cima4"))
        swipeUpArray.append(swipeUpAtlas.textureNamed("arrastar_cima5"))
    }
    
    func initAnimationSwipe(swipeNode: SKSpriteNode, Down: Bool){
        if (Down){
            let animation1 = SKAction.repeatActionForever(SKAction.animateWithTextures(swipeDownArray, timePerFrame: 0.3))
            let delay = SKAction.waitForDuration(2)
            let sequence = SKAction.sequence([animation1, delay])
            swipeAnimation = SKAction.repeatActionForever(sequence)
            swipeNode.runAction(swipeAnimation)
        } else {
            let animation1 = SKAction.repeatActionForever(SKAction.animateWithTextures(swipeUpArray, timePerFrame: 0.3))
            let delay = SKAction.waitForDuration(2)
            let sequence = SKAction.sequence([animation1, delay])
            swipeAnimation = SKAction.repeatActionForever(sequence)
            swipeNode.runAction(swipeAnimation)
        }
    }
    
    
    func transitionSceneBackground(backgroundBlack: Bool, completion: (Void) -> Void){
        eCenoura = false
        if(inventoryPresent==true){
            swipeUp()
            if let swipeTest = self.childNodeWithName("swipeUpTutorial"){
                Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "swipeUp", object: true)
                swipeTest.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                    swipeTest.removeFromParent()})
            }
            
        }
        self.removeVisionButtonsScene()
        
        curtains.runAction(SKAction.animateWithTextures(animationCurtainsClosed, timePerFrame: 0.1), completion: {
            self.removeObjects({
                self.userInteractionEnabled = false
                self.sceneBackground.touchRuning = false
                let sceneBaseView = self.view!.superview! as! SKView
                self.sceneBackground.theater = self
                self.sceneBackground.userInteractionEnabled = false
                sceneBaseView.presentScene(self.sceneBackground)
                self.mainCharacter.offsetAlexWalk = self.sceneBackground.offsetWalkScene
                self.camera = self.sceneBackground.camera
                //self.removeFromParent()
                //self.sceneBackground.backgroundMusic.removeFromParent()
                self.addObjects()
                self.inventoryPresent = false
                
                completion()
                
                self.curtains.runAction(SKAction.animateWithTextures(self.animationCurtainsOpen, timePerFrame: 0.1), completion: {
                    self.userInteractionEnabled = true
                    self.flagCurtinsClosed = false
                    self.inventoryPresent = false
                    self.showVisionButtonsScene()
                })
            })
        })
    }
    
    /*TOUCH's FUCTION */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if(!self.flagStartTouchedBeganTheater){
            self.flagStartTouchedBeganTheater = true
            let sceneBaseView = self.view!.superview! as! SKView
            let sceneBase = sceneBaseView.scene!
            
            if(inventoryPresent==true){
                swipeUp()
                if let swipeTest = self.childNodeWithName("swipeUpTutorial"){
                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "swipeUp", object: true)
                    swipeTest.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                        swipeTest.removeFromParent()})
                }
            }
            //Selecting pause menu
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
                let nodeTouched: SKNode = self.nodeAtPoint(location)
                if(nodeTouched == saco && pauseMenuCounter == 0){
                    pauseMenuCounter++
                    flagCurtinsClosed = true
                    curtains.runAction(SKAction.animateWithTextures(animationCurtainsClosed, timePerFrame: 0.1))
                    removeVisionButtonsScene()
                    effectConfiguration(selectionButtonSound, waitC: true)
                    pauseMenu()
                    self.flagStartTouchedBeganTheater = false
                } else {
                    let index = self.nodesAtPoint(location).startIndex.advancedBy(1)
                    if let nodeTouched: SKNode = self.nodesAtPoint(location)[index] {
                        if(nodeTouched.name == nil){
                            itenHasMoved = false
                            selectedNode = nodeTouched as! SKSpriteNode
                            selectedNodeZPosition = selectedNode.zPosition
                        }
                    }
                    self.flagStartTouchedBeganTheater = false
                }
            }else{
                self.flagStartTouchedBeganTheater = false
            }
            //print("Touch: \(pauseMenuPresent)")
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.flagStartTouchedBeganTheater){
            self.flagStartTouchedBeganTheater = true
            if let touch = touches.first {
                let positionInScene = touch.locationInNode(self)
                let previousPosition = touch.previousLocationInNode(self)
                let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
                itenHasMoved = true
                if(selectedNode != nil){
                    selectedNode.zPosition = 99
                    self.panForTranslation(translation)
                }
            }
            self.flagStartTouchedBeganTheater = false
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.flagStartTouchedBeganTheater){
            self.flagStartTouchedBeganTheater = true
            let sceneBaseView = self.view!.superview! as! SKView
            let sceneBase = sceneBaseView.scene!
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                let index = self.nodesAtPoint(location).startIndex.advancedBy(1)
                let nodeTouched = self.nodesAtPoint(location)[index] as! SKSpriteNode
                
                if(nodeTouched.name == nil && itenHasMoved == false){
                    if let click = self.childNodeWithName("cliquePedras"){
                        click.removeFromParent()
                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliquePedras", object: true)
                    }
                    if (!eCenoura) {
                        self.catchObject(self, location: location, object: nodeTouched)
                        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Tutorial"){
                            let click = dictionary["swipeDown"] as! Bool
                            if (!click) {
                                if let mao = self.childNodeWithName("swipeDownTutorial"){
                                // do nothing
                                } else {
                                    setupSwipe(true)
                                    initAnimationSwipe(swipeDSprite, Down: true)
                                }
                            }
                        }
                    }else{
                        self.flagStartTouchedBeganTheater = false
                    }
                    
                    if (SKTexture.returnNameTexture(nodeTouched.texture!) == "verduras"){
                        eCenoura = true
                        //self.removeVerduras()
                        
//                        self.sceneBackground.enumerateChildNodesWithName("", usingBlock: {
//                            node, stop in
//                            node.runAction(SKAction.fadeAlphaTo(0, duration: 0.2))
//                            node.removeFromParent()
//                        })
                    }
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
                        if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                            let indexDataScene = dictionaryDataScene.indexForKey("Finished")
                            let arrayFinished = dictionaryDataScene[indexDataScene!].1 as! NSArray
                            let arrayCaldeirao = dictionaryDataScene[dictionaryDataScene.indexForKey("caldeirao")!].1 as! NSArray
                            var array = NSMutableArray(array: arrayFinished)
                            array.addObject(SKTexture.returnNameTexture(nodeTouched.texture!))
                            
                            Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Finished", object: array as NSArray)
                            
                            var completeLevel: Bool = true
                            
                            for object in arrayCaldeirao {
                                if !(array.containsObject(object as! String)){
                                    completeLevel = false
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "completedLevel", object: false)
                                }
                            }
                            
                            if(completeLevel){
                                if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                                    let indexDataScene = dictionaryDataScene.indexForKey("Characters")
                                    let dict = dictionaryDataScene[indexDataScene!].1 as! NSDictionary
                                    dict.setValue(2, forKey: "Viajante")
                                    dict.setValue(0, forKey: "Velha")
                                    Dictionary<String, AnyObject>.saveGameData("Level" + String(self.numberLevel), key: "Characters", object: dict)
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "completedLevel", object: true)
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueChao", object: true)
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueViajante", object: true)
                                    Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliquePedras", object: true)
                                    showViajante2 = true
                                }
                            }
                        }
                        nodeTouched.removeFromParent()
                    }else{
                        selectedNode.zPosition = selectedNodeZPosition
                        fallingIten(selectedNode as! SKSpriteNode, fromInventory: false)
                        selectedNode = nil
                    }
                    self.flagStartTouchedBeganTheater = false
                }else if (nodeTouched.name != nil){
                    self.flagStartTouchedBeganTheater = false
                    sceneBase.touchesBegan(touches, withEvent: event)
                }
            }
        }
    }
    
    func objectsInteraction(fixedObject: SKSpriteNode, receivedObject: SKSpriteNode) -> Bool? {
        let nameFixedObject = SKTexture.returnNameTexture(fixedObject.texture!)
        let nameReceivedObject = SKTexture.returnNameTexture(receivedObject.texture!)
        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
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
                if let dictionaryDataScene = Dictionary<String, AnyObject>.loadGameData("Level" + String(self.numberLevel)) {
                    let indexDataScene = dictionaryDataScene.indexForKey("Finished")
                    let array = dictionaryDataScene[indexDataScene!].1 as! NSArray
                    if !(array.containsObject(string)) {
                        let dictionary = dictionaryDataScene[dictionaryDataScene.indexForKey("Inventory")!].1 as! NSDictionary
                        let dict = dictionary as! Dictionary<String, AnyObject>
                        if let objectDict = dict[string] {
                            let objectBool = objectDict as! Bool
                            if(objectBool){
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
        self.inventoryPresent = false
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
                
            case "Alex":
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
    
    func updateSwipes(){
        if ((swipeDSprite) != nil){
            swipeDSprite.position.x = 1020 + self.camera!.position.x - 512
        }
        if ((swipeUSprite) != nil){
            swipeUSprite.position.x = 1020 + self.camera!.position.x - 512
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (SceneGameBase.flagSwipe){
            SceneGameBase.flagSwipe = false
            if let swipeTest = self.childNodeWithName("swipeUpTutorial"){
                Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "swipeUp", object: true)
                swipeTest.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                    swipeTest.removeFromParent()})
            }
            if let swipeTest = self.childNodeWithName("swipeDownTutorial"){
                Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "swipeDown", object: true)
                swipeTest.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                    swipeTest.removeFromParent()})
            }
            setupSwipe(false)
            initAnimationSwipe(swipeUSprite, Down: false)
        }
        
        updateCameraSceneDefault()
        if(!flagCurtinsClosed){
            updateButtonsScene()
            updateSwipes()

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
