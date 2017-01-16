//
//  TitleScene.swift
//  sample as
//
//  Created by takahashi yuki on 2016/12/31.
//  Copyright © 2016年 takahashi yuki. All rights reserved.
//

import Foundation
import SpriteKit

class TitleScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let titleLabel = SKLabelNode(fontNamed:"Copperplate")
        titleLabel.text = "Assenble MEN"
        titleLabel.fontSize = 50
        titleLabel.position = CGPoint(x:self.frame.width/2, y: self.frame.height*3/4)
        self.addChild(titleLabel)
        
        
        let flagLabel = SKLabelNode(fontNamed: "Copperplate")
        flagLabel.text = "Natinalflag"
        flagLabel.fontSize = 40
        flagLabel.position = CGPoint(x:self.frame.width/2, y: self.frame.height/2)
        flagLabel.name = "flag"
        self.addChild(flagLabel)
        
        let hamburgerLabel = SKLabelNode(fontNamed: "Copperplate")
        hamburgerLabel.text = "Hamburger"
        hamburgerLabel.fontSize = 40
        hamburgerLabel.position = CGPoint(x:self.frame.width/2, y: self.frame.height/4)
        hamburgerLabel.name = "hamburger"
        self.addChild(hamburgerLabel)
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch:AnyObject in touches{
            let touchlocation = touch.location(in:self)
            
            if self.atPoint(touchlocation).name == "flag"{
                let scene = GameScene()
                scene.size = self.frame.size
                view?.presentScene(scene)
                
            }
            
        }

        
      
    }

    override func update(_ currentTime: CFTimeInterval) {}
}
