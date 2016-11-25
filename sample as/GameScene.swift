//
//  GameScene.swift
//  sample as
//
//  Created by takahashi yuki on 2016/11/22.
//  Copyright © 2016年 takahashi yuki. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var baseNode:SKNode!
    var tpos:CGPoint!
    var timer = Timer()
    var sbango = 0
    //Materialを格納する配列
    var Mate = [Material]()
    var width :CGFloat? = 0.0
    var height :CGFloat? = 0.0
    override func didMove(to view: SKView) {
        
        let baseNode = SKNode()
        baseNode.zPosition = 4
        self.addChild(baseNode)
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    
        //マテリアル生成タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.create), userInfo: nil, repeats: true)
        print(self.frame.size.width)
        
        width = self.frame.size.width
        height = self.frame.size.height
    }
   
    /*マテリアル生成*/
    func create(){
        let mate = Material()
        //こっちじゃないとフレーム指定できないのでこちらでポジション指定
        let framew = self.frame.size.width
        let frameh = self.frame.size.height
        mate.position = CGPoint(x:framew/2,y:frameh*2/3)
        //移動設定
        let move = SKAction.moveBy(x: 0, y: -self.size.height, duration: 2)
        mate.run(move)
        self.Mate.append(mate)
        self.addChild(mate)
    }
  
    /*タッチ処理*/
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
        
        Mate[self.sbango].removeFromParent()
        self.sbango = self.sbango+1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        for t in touches { self.touchDown(atPoint: t.location(in: self))
                           tpos = t.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
                           let epos = t.location(in: self)
                           let hantei = Int(tpos.x)-Int(epos.x)
            if(hantei>15){
                /*左にスライドした時の処理*/
                if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                    n.position = t.location(in: self)
                    n.strokeColor = SKColor.white
                    self.addChild(n)
                }
                    //落ちるのをストップし、左の位置へ
                    Mate[self.sbango].removeAllActions()
                    Mate[self.sbango].moveLeft()
                    self.sbango = self.sbango+1
                
            } else if(hantei < -15){
                /*右にスライドした時の処理*/
                if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                    n.position = t.location(in: self)
                    n.strokeColor = SKColor.white
                    self.addChild(n)
                }
                    //落ちるのをストップし、右の位置へ
                    Mate[self.sbango].removeAllActions()
                    Mate[self.sbango].moveRight()
                    self.sbango = self.sbango+1
                
            
            }else{
                 self.touchUp(atPoint: t.location(in: self))
            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    /*ここまでタッチ処理*/
    
    func getwidth()->CGFloat{
        return self.width!
    }
    
    func getheight()->CGFloat{
        return self.height!
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
