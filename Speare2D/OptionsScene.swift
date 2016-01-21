//
//  InfoScene.swift
//  Speare2D
//
//  Created by Alessandra Pereira on 25/10/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class OptionsScene: SceneDefault {
    var countTicketAnimation: Int = 0
    var ticketTurn: Bool = true

    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        musicBgConfiguration(optionsBGmusic)
        countTicketAnimation = 0
        ticketTurn = true
        
        let musicButton = self.childNodeWithName("musicButton") as! SKSpriteNode
        let effectsButton = self.childNodeWithName("effectsButton") as! SKSpriteNode
        
        if let dictionary = Dictionary<String,AnyObject>.loadGameData("Audios"){
            let music = dictionary["music"] as! Bool
            let effects = dictionary["effects"] as! Bool
            
            if(music){
                self.backgroundMusic.runAction(SKAction.play())
                musicButton.texture = SKTexture(imageNamed: "musicButton")
            }else{
                self.backgroundMusic.runAction(SKAction.pause())
                musicButton.texture = SKTexture(imageNamed: "withoutMusicButton")
            }
            
            if(effects){
                effectsButton.texture = SKTexture(imageNamed: "effectsButton")
            }else{
                effectsButton.texture = SKTexture(imageNamed: "withoutEffectsButton")
            }
        }
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!self.touchRuning){
            touchRuning = true
            if let touch = touches.first{
                let location = touch.locationInNode(self)
                let nodeTouched = self.nodeAtPoint(location)
                let nome = nodeTouched.name!
                switch nome{
                case "musicButton":
                    effectConfiguration(selectionButtonSound, waitC: true)
                    if(SKTexture.returnNameTexture((nodeTouched as! SKSpriteNode).texture!) == "withoutMusicButton"){
                        self.backgroundMusic.runAction(SKAction.changeVolumeTo(SceneDefault.bgMusicVolume, duration: 0))
                        (nodeTouched as! SKSpriteNode).texture = SKTexture(imageNamed: "musicButton")
                        Dictionary<String,AnyObject>.saveGameData("Audios", key: "music", object: true)
                    }else{
                        self.backgroundMusic.runAction(SKAction.changeVolumeTo(0, duration: 0))
                        (nodeTouched as! SKSpriteNode).texture = SKTexture(imageNamed: "withoutMusicButton")
                        Dictionary<String,AnyObject>.saveGameData("Audios", key: "music", object: false)
                    }
                    self.touchRuning = false
                    break
                    
                case "ticketBackButton":
                    effectConfiguration(backButtonSound, waitC: true)
                    self.transitionNextScene(self, sceneTransition: Home(fileNamed: "Home")!, withTheater: false)
                    break
                    
                case "effectsButton":
                    effectConfiguration(selectionButtonSound, waitC: true)
                    if(SKTexture.returnNameTexture((nodeTouched as! SKSpriteNode).texture!) == "withoutEffectsButton"){
                        (nodeTouched as! SKSpriteNode).texture = SKTexture(imageNamed: "effectsButton")
                        Dictionary<String,AnyObject>.saveGameData("Audios", key: "effects", object: true)
                    }else{
                        (nodeTouched as! SKSpriteNode).texture = SKTexture(imageNamed: "withoutEffectsButton")
                        Dictionary<String,AnyObject>.saveGameData("Audios", key: "effects", object: false)
                    }
                    self.touchRuning = false
                    break
                    
                default:
                    self.touchRuning = false
                    break
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(countTicketAnimation==300){
            countTicketAnimation = 0
            ticketTurn = !ticketTurn
            if(!touchRuning){
                if(ticketTurn){
                   animationTicket(self.childNodeWithName("musicButton") as! SKSpriteNode)
                } else {
                    animationTicket(self.childNodeWithName("effectsButton") as! SKSpriteNode)
                }
            }
        }else{
            countTicketAnimation++
        }
    }
    
    func animationTicket(Object: SKSpriteNode){
        let spin1 = SKAction.rotateToAngle(CGFloat(0.2), duration: 0.2)
        let spin2 = SKAction.rotateToAngle(CGFloat(-0.2), duration: 0.2)
        let spin3 = SKAction.rotateToAngle(CGFloat(0), duration: 0.2)
        let group = SKAction.sequence([spin1, spin2, spin3])
        Object.runAction(group)
    }

}