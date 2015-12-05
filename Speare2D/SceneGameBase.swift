//
//  SceneBase.swift
//  Speare2D
//
//  Created by Dayane Kelly Rodrigues da Silva on 09/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import SpriteKit

class SceneGameBase: SceneDefault {
    
    //inventory
    var inventory: Inventory = Inventory(fileNamed: "Inventory")!
    var viewInventory: SKView!
    var inventoryPresent: Bool = false
    static var itenComing: Bool = false
    static var itenFromInventory: SKSpriteNode!
    
    //arquivo
    var fileName: String!
    
    /*SWIPE's FUNCTION */
    func addSwipes(view: UIView){
        //Add swipe in the view (self.view)
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDown)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(swipeUp)
    }
    
    func swipeDown(sender: UISwipeGestureRecognizer){
        /* Function to display the inventory */
        print(sender.locationInView(self.view))
        let location = CGPointMake(sender.locationInView(self.view).x, 768 - sender.locationInView(self.view).y)
        print(location)
        if location.x > 990 && location.x < 1010 && location.y > 500 && location.y < 650 && inventoryPresent==false {
            //limits the recognition area swipe
                self.viewInventory = SKView(frame: CGRectMake(0, -150, 1024, 150))
                self.view?.addSubview(viewInventory as UIView)
                self.viewInventory.backgroundColor = UIColor.clearColor()
                self.viewInventory.presentScene(inventory)
            
                let cortina = self.childNodeWithName("cortina") as! SKSpriteNode
                let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
                let corda = self.childNodeWithName("cordaInventario") as! SKSpriteNode
                cortina.runAction(SKAction.moveToY(660, duration: 1))
                saco.runAction(SKAction.moveToY(540.25, duration: 1))
                corda.runAction(SKAction.moveToY(528.75, duration: 1))
                self.viewInventory.cheetah.move(0, 130).duration(1).run()
                inventoryPresent = true
        }else{
            /* Function to use swipe on the main chaacter */
            
        }
    }
    
    func swipeUp(){
        if(inventoryPresent==true){
            let cortina = self.childNodeWithName("cortina") as! SKSpriteNode
            let saco = self.childNodeWithName("sacoOpcao") as! SKSpriteNode
            let corda = self.childNodeWithName("cordaInventario") as! SKSpriteNode
            saco.runAction(SKAction.moveToY(646.5, duration: 1))
            corda.runAction(SKAction.moveToY(635, duration: 1))
            self.viewInventory.cheetah.move(0, -130).duration(1).run()
            cortina.runAction(SKAction.moveToY(766.25, duration: 1), completion: {
                self.viewInventory.removeFromSuperview()
                self.inventoryPresent = false
            })
        }
    }
}
