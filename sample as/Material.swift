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
    
    //マテリアルのズレ保持
    static var rightn = CGFloat(0.0)
    static var leftn = CGFloat(0.0)
    
    var level = 3.5 //難易度　どれくらいの速度で流れてくるか
    static var bango = 0//通し番号
    
    let matekind:String//マテリアルの種別

    init(){
        
        
        let random : Int = Int(arc4random() % 4)
        
    
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
        default :
            color = UIColor.blue
            self.matekind = "blue"
        }
        //画像、色、サイズ、位置、通し番号の設定
        super.init(texture: nil,color: color,size: CGSize(width:20.0,height:80.0))
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:80, height:20))
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
                
                print(GameScene().sbango)
                GameScene().Upsbango()
                
        }
    }
    
    
    func moveRight(){
        let right = SKAction.move(to: CGPoint(x:self.position.x + 80.0 + Material.rightn,y:500.0), duration: 0.1)
        Material.rightn += 20.0
        self.run(right)
    }
    
    func moveLeft(){
        let left = SKAction.move(to: CGPoint(x:self.position.x + -140.0 + Material.leftn,y:500.0), duration: 0.1)
        Material.leftn += 20.0
        self.run(left)

        
    }
    
    /*通し番号の取得*/
    func Getbango()->Int{
        let a = Material.bango
        return a
    }

}
