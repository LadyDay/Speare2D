//
//  StartScene.swift
//  Speare2Dtela2
//
//  Created by Alessandra Pereira on 20/10/15.
//  Copyright © 2015 Alessandra Pereira. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SceneDefault {
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        mainCharacter.setupAlex()
        addChild(mainCharacter)
        setCamera()
        
        //SceneDefault.bgMusicVolume = 0.7
        //SceneDefault.effectsVolume = 0.7
        //SceneDefault.voiceVolume = 0.7
        musicBgConfiguration(startBGmusic)
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
            if let touch = touches.first{
                var location = touch.locationInNode(self)
                for nodeTouched in self.nodesAtPoint(location){
                    guard let nome = nodeTouched.name else {continue ;}
                    switch nome{
                        /*
                    case "Sopa De Pedra":
                        effectConfiguration(selectionButtonSound, waitC: true)
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            //Muda cena para Opção1
                            //effectConfiguration(selectionButtonSound, waitC: true)
                            self.touchRuning = false
                            self.transitionNextScene(self, sceneTransition: TutorialScene(fileNamed: "TutorialScene")!, withTheater: true)
                            //self.transitionNextScene(KitchenScene(fileNamed: "KitchenScene")!, withTheater: true)
                        })
                        break
                        */
                        
                    case "maoTutorial":
                        //let position = maoTutorial.position
                        //remove o sprite
                        //chama a função de mover a Alex até o ponto onde estava a mão
                        
                        break
                        
                    case "exitNode":
                        effectConfiguration(backButtonSound, waitC: true)
                        //chama a animação para a bilheteria
                        location = CGPoint(x: -70, y: 300)
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            //Volta ao menu
                            self.touchRuning = false
                            self.transitionNextScene(self, sceneTransition: Home(fileNamed: "Home")!, withTheater: false)
                        })
                        break
                        
                    default:
                        if let dictionaryStateGame = Dictionary<String, AnyObject>.loadGameData("StateGame"){
                            if let dictionaryTableLevels = Dictionary<String, AnyObject>.loadGameData("TableNamesLevels"){
                                if dictionaryTableLevels.indexForKey(nome) != nil {
                                    let numberLevelSelected = dictionaryTableLevels[dictionaryTableLevels.indexForKey(nome)!].1 as! NSNumber
                                    let numberLevelCurrent = dictionaryStateGame[dictionaryStateGame.indexForKey("currentLevel")!].1 as! NSNumber
                                    //o meu level atual coencide com o selecionado
                                    if(numberLevelCurrent.integerValue == numberLevelSelected.integerValue){
                                        effectConfiguration(selectionButtonSound, waitC: true)
                                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                            //Muda cena para Opção1
                                            //effectConfiguration(selectionButtonSound, waitC: true)
                                            self.touchRuning = false
                                            let string = "Speare2D." + (dictionaryStateGame[dictionaryStateGame.indexForKey("currentScene")!].1 as! String)
                                            print(string)
                                            let anyobjectype : AnyObject.Type = NSClassFromString(string)!
                                            let classString : SKScene.Type = anyobjectype as! SKScene.Type
                                            let sceneTransition = classString.init(fileNamed: dictionaryStateGame[dictionaryStateGame.indexForKey("currentScene")!].1 as! String)
                                            self.transitionNextScene(self, sceneTransition: sceneTransition!, withTheater: true)
                                            })
                                    }else if (numberLevelCurrent.integerValue > numberLevelSelected.integerValue){
                                        
                                    }else{
                                        //tentando reproduzir um level maior do que o atual
                                        self.touchRuning = false
                                    }
                                }else{
                                    if location.y<200 {
                                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                            self.touchRuning = false
                                        })
                                    }else{
                                        self.touchRuning = false
                                    }
                                }
                            }
                        }
                        break
                    }
                }
            }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        updateCameraSceneDefault()
    }
    
}
