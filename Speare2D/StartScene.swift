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
        self.userInteractionEnabled = true
        mainCharacter.setupAlex()
        addChild(mainCharacter)
        setCamera()
        musicBgConfiguration(startBGmusic)
        
        //Colocar um if para arquivos, para apenas exibir essa mão na primeira vez:
        if let dictionary = Dictionary<String, AnyObject>.loadGameData("Tutorial"){
            let click = dictionary["cliqueCartaz"] as! Bool
            if(!click){
                initClickTexture()
                initClick(self.childNodeWithName("clique") as! SKSpriteNode)
            }else{
                self.childNodeWithName("clique")?.removeFromParent()
            }
        }
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
                        
                    case "clique":
                        let click = self.childNodeWithName("clique")
                        click?.removeFromParent()
                        Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueCartaz", object: true)
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
                                    
                                    if let dictionaryLevel = Dictionary<String, AnyObject>.loadGameData("Level"+String(numberLevelSelected)){
                                        //o meu level atual coencide com o selecionado
                                        if(numberLevelSelected.integerValue <= numberLevelCurrent.integerValue){
                                            effectConfiguration(selectionButtonSound, waitC: true)
                                            mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                                //Muda cena para Opção1
                                                //effectConfiguration(selectionButtonSound, waitC: true)
                                                Dictionary<String, AnyObject>.saveGameData("Tutorial", key: "cliqueCartaz", object: true)
                                                self.fileName = dictionaryLevel["currentScene"] as! String
                                                self.numberLevel = numberLevelSelected
                                                
                                                self.touchRuning = false
                                                let string = "Speare2D." + (dictionaryLevel[dictionaryLevel.indexForKey("currentScene")!].1 as! String)
                                                print(string)
                                                let anyobjectype : AnyObject.Type = NSClassFromString(string)!
                                                let classString : SKScene.Type = anyobjectype as! SKScene.Type
                                                let sceneTransition = classString.init(fileNamed: dictionaryLevel[dictionaryLevel.indexForKey("currentScene")!].1 as! String)
                                                self.transitionNextScene(self, sceneTransition: sceneTransition!, withTheater: true)
                                            })
                                        }else if (numberLevelCurrent.integerValue > numberLevelSelected.integerValue){
                                            self.touchRuning = false
                                        }else{
                                            //tentando reproduzir um level maior do que o atual
                                            self.touchRuning = false
                                        }
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
