//
//  Introdution.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 1/20/16.
//  Copyright © 2016 LadyDay. All rights reserved.
//

import UIKit
import SpriteKit

class Introdution: SceneDefault {
    
    let introTextureAtlas = SKTextureAtlas(named: "Introdution.atlas")
    var introSpriteArray = Array<SKTexture>()
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        self.userInteractionEnabled = false
        let image = self.childNodeWithName("introdution") as! SKSpriteNode
        initSprites()
        let action = SKAction.animateWithTextures(introSpriteArray, timePerFrame: 1.5)
        image.runAction(action, completion: {
            if let dictionary = Dictionary<String,AnyObject>.loadGameData("Tutorial"){
                let dict = dictionary["introdutionPresent"] as! Bool
                if(!dict){
                    Dictionary<String,AnyObject>.saveGameData("Tutorial", key: "introdutionPresent", object: true)
                    self.transitionNextScene(self, sceneTransition: StartScene(fileNamed: "StartScene")!, withTheater: false)
                }else{
                    self.transitionNextScene(self, sceneTransition: InfoScene(fileNamed: "InfoScene")!, withTheater: false)
                }
            }
        })
    }
    
    func initSprites(){
        introSpriteArray.append(introTextureAtlas.textureNamed("introSprite1"))
        introSpriteArray.append(introTextureAtlas.textureNamed("introSprite2"))
        introSpriteArray.append(introTextureAtlas.textureNamed("introSprite3"))
    }
}
