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
    var optionView: SKView!
    
    let switchSubtitles = UISwitch(frame:CGRectMake(525, 500, 0, 0))
    let bgMusicSlider = UISlider(frame:CGRectMake(580, 200, 280, 20))
    let effectsSlider = UISlider(frame:CGRectMake(580, 300, 280, 20))
    let voiceSlider = UISlider(frame:CGRectMake(580, 400, 280, 20))
    let backButton = UIButton(frame: CGRectMake(500, 600, 100, 50))
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        setUpView()
        let gameScene = Home(fileNamed: "Home")
        musicBgConfiguration(startBGmusic)
        
        
        addSlider(bgMusicSlider, volume: bgMusicVolume)
        addSlider(effectsSlider, volume: effectsVolume)
        addSlider(voiceSlider, volume: voiceVolume)
        addSwitch(switchSubtitles, beginsOn: true)
        addButton(backButton)
        
        
    }
    
    /* Called when a touch begins */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //viewInit()
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    func setUpView(){
        self.optionView = SKView(frame: CGRectMake(0, 0, 1024, 768))
        
        self.view?.addSubview(optionView as UIView)
        //self.optionView.backgroundColor = UIColor.whiteColor()
        //self.view?.backgroundColor = UIColor.whiteColor()
        //view = self.optionView
    }
    
    func addSlider(Slider: UISlider, volume: Float){
        let sliderDemo = Slider
        
        sliderDemo.minimumValue = 0
        sliderDemo.maximumValue = 1
        sliderDemo.continuous = true
        sliderDemo.tintColor = UIColor.redColor()
        sliderDemo.value = volume
        sliderDemo.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        self.optionView.addSubview(sliderDemo)
    }
    
    func sliderValueDidChange(sender:UISlider!)
    {
        //print("sender: \(sender.layer) - value: \(sender.value)")
        //print("bgMusicSlider.layer: \(bgMusicSlider.layer) - value: \(bgMusicSlider.value) ")
        if sender.layer == bgMusicSlider.layer {
            backgroundMusic.runAction(SKAction.changeVolumeTo(sender.value, duration: 0))
            self.bgMusicVolume = sender.value
        } else if sender.layer == effectsSlider.layer {
            //effectsMusic.runAction(SKAction.changeVolumeTo(sender.value, duration: 0))
            self.effectsVolume = sender.value
        } else if sender.layer == voiceSlider.layer {
            //effectsMusic.runAction(SKAction.changeVolumeTo(sender.value, duration: 0))
            self.voiceVolume = sender.value
        }
        
    }
    
    func addSwitch(Switch: UISwitch, beginsOn: Bool){
        let switchDemo = Switch
        let onOff = beginsOn
        
        switchDemo.on = onOff
        switchDemo.setOn(true, animated: false);
        switchDemo.addTarget(self, action: "switchValueDidChange:", forControlEvents: .ValueChanged);
        self.optionView.addSubview(switchDemo);
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    func addButton(Button: UIButton){
        let buttonDemo = Button
        buttonDemo.backgroundColor = UIColor.blackColor()
        buttonDemo.setTitle("Voltar", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = 22;
        self.optionView!.addSubview(buttonDemo)
    }
    
    func buttonAction(sender:UIButton!)
    {
        //var btnsendtag:UIButton = sender
        if sender.tag == 22 {
            print("Button tapped tag 22")
            let fadeScene = SKTransition.fadeWithDuration(1.0)
            let gameScene = Home(fileNamed: "Home")
            gameScene?.bgMusicVolume = self.bgMusicVolume
            gameScene?.effectsVolume = self.effectsVolume
            gameScene?.voiceVolume = self.voiceVolume
            optionView.removeFromSuperview()
          
            self.view?.presentScene(gameScene!, transition: fadeScene)
        }
    }
    
}