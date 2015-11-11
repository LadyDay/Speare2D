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
    
    let switchSubtitles = UISwitch(frame:CGRectMake(525, 440, 0, 0))
    let bgMusicSlider = UISlider(frame:CGRectMake(580, 200, 280, 20))
    let effectsSlider = UISlider(frame:CGRectMake(580, 300, 280, 20))
    let backButton = UIButton(frame: CGRectMake(500, 400, 100, 50))
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        bgMusicVolume = 0.7
        effectsVolume = 0.7
        musicBgConfiguration("backgroundMusic.mp3")
        
        
        addSlider(bgMusicSlider, volume: bgMusicVolume)
        addSlider(effectsSlider, volume: effectsVolume)
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
    
    func addSlider(Slider: UISlider, volume: Float){
        let sliderDemo = Slider
        
        sliderDemo.minimumValue = 0
        sliderDemo.maximumValue = 1
        sliderDemo.continuous = true
        sliderDemo.tintColor = UIColor.redColor()
        sliderDemo.value = volume
        sliderDemo.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        self.view!.addSubview(sliderDemo)
    }
    
    func sliderValueDidChange(sender:UISlider!)
    {
        //print("sender: \(sender.layer) - value: \(sender.value)")
        //print("bgMusicSlider.layer: \(bgMusicSlider.layer) - value: \(bgMusicSlider.value) ")
        if sender.layer == bgMusicSlider.layer {
            backgroundMusic.runAction(SKAction.changeVolumeTo(sender.value, duration: 0))
            bgMusicVolume = sender.value
        } else if sender.layer == effectsSlider.layer {
            //effectsMusic.runAction(SKAction.changeVolumeTo(sender.value, duration: 0))
            effectsVolume = sender.value
        }
        
    }
    
    func addSwitch(Switch: UISwitch, beginsOn: Bool){
        let switchDemo = Switch
        let onOff = beginsOn
        
        switchDemo.on = onOff
        switchDemo.setOn(true, animated: false);
        switchDemo.addTarget(self, action: "switchValueDidChange:", forControlEvents: .ValueChanged);
        self.view!.addSubview(switchDemo);
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
        buttonDemo.backgroundColor = UIColor.greenColor()
        buttonDemo.setTitle("Botão!!!", forState: UIControlState.Normal)
        buttonDemo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonDemo.tag = 22;
        self.view!.addSubview(buttonDemo)
    }
    
    func buttonAction(sender:UIButton!)
    {
        //var btnsendtag:UIButton = sender
        if sender.tag == 22 {
            print("Button tapped tag 22")
        }
    }
    
}