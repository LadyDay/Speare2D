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
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
            if let touch = touches.first{
                var location = touch.locationInNode(self)
                for nodeTouched in self.nodesAtPoint(location){
                    guard let nome = nodeTouched.name else {continue ;}
                    switch nome{
                    case "tutorial":
                        effectConfiguration(selectionButtonSound, waitC: true)
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: nodeTouched.position, tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            //Muda cena para Opção1
                            //effectConfiguration(selectionButtonSound, waitC: true)
                            self.touchRuning = false
                            self.transitionNextScene(TutorialScene(fileNamed: "TutorialScene")!, withTheater: true)
                        })
                        break
                        
                    case "exitNode":
                        effectConfiguration(backButtonSound, waitC: true)
                        //chama a animação para a bilheteria
                        location = CGPoint(x: -70, y: 300)
                        mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                            //Volta ao menu
                            self.touchRuning = false
                            self.transitionNextScene(Home(fileNamed: "Home")!, withTheater: false)
                        })
                        break
                        
                    default:
                        if location.y<200 {
                            mainCharacter.runAction(mainCharacter.walk(mainCharacter.position, touchLocation: touch.locationInNode(self), tamSize: 2048, objectPresent: false, objectSize: nil), completion: {
                                self.touchRuning = false
                            })
                        }else{
                            self.touchRuning = false
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
