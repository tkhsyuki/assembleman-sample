//
//  Material.swift
//  sample as
//
//  Created by takahashi yuki on 2016/11/23.
//  Copyright © 2016年 takahashi yuki. All rights reserved.
//

import Foundation
import SpriteKit

class Material:  SKSpriteNode{
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
    }
    
    var timer = Timer()
    
    static var bango = 0//通し番号
    
    let matekind:String//マテリアルの種別

    init(){
        
        
        let random : Int = Int(arc4random_uniform(5))
        
        var RorL:String?
        var color : UIColor!
        
        switch random {
        case 0 :
            color = UIColor.red
            self.matekind = "red"
        case 1 :
            color = UIColor.white
            self.matekind = "white"
        case 2 :
            color = UIColor.green
            self.matekind = "green"
        case 3 :
            color = UIColor.blue
            self.matekind = "blue"
        case 4 :
            color = UIColor.white
            self.matekind = "white"
        default :
            color = UIColor.blue
            self.matekind = "white"
        }
        //画像、色、サイズ、位置、通し番号の設定
        super.init(texture: nil,color: color,size: CGSize(width:40.0,height:80.0))
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:300, height:500))
        self.zPosition = 2
        self.physicsBody?.isDynamic=false
        Material.bango = Material.bango+1
        //1秒ごとにupdate関数を実行
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Material.update), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*マテリアルの状態遷移*/
    func update(){
        
        
            if self.position.y < -self.size.height{
                self.removeFromParent()
                self.timer.invalidate()
            let sound = SKAction.playSoundFileNamed("slap1.mp3", waitForCompletion: true)
            GameScene().run(sound)

                
        }
    }
    
      }



