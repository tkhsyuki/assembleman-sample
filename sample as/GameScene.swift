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
    
    //trueでタッチ受付、out of index を防止,マテリアルが画面にある時のみtrueになるように.
    var active = false
    
    //スライド判定に使う
    var tpos:CGPoint!
    var timer = Timer()
    
    //処理時に参照するマテリアル一つ一つに割り振られている番号
    var  sbango = 0
    
    //Materialを格納する配列
    var Mate = [Material]()
    
    //frameのサイズ簡略のため
    var width :CGFloat? = 0.0
    var height :CGFloat? = 0.0
    
    //削除のためにsbangoを格納しておく
    var Rtable = [Int]()
    var Ltable = [Int]()

    
    override func didMove(to view: SKView) {
        
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
        
        //フレームの大きさ設定
        width = self.frame.size.width
        height = self.frame.size.height
        
        //テーブルの作成
        maketable()
    }
   
    /*マテリアル生成*/
    func create(){
        let mate = Material()
        //こっちじゃないとフレーム指定できない?のでこちらでポジション指定
        let framew = self.frame.size.width
        let frameh = self.frame.size.height
        mate.position = CGPoint(x:framew/2,y:frameh*2/3)
        
                //移動設定
        let move = SKAction.moveBy(x: 0, y: -self.size.height, duration: 2)
        mate.run(move)
        self.Mate.append(mate)
        self.addChild(mate)
        active = true
    }
    
    /*スコア増加*/
    func addscore(kuni:String){
        //ラベルに国の名前を表示
        let Kind = SKLabelNode(text:"\(kuni)")
        Kind.alpha = 0.5
        Kind.fontSize = 40.0
        Kind.position = CGPoint(x:width!/2,y:height!/2)
        //一秒で消えるようにして追加
        let fade = SKAction.fadeOut(withDuration: 1)
        Kind.run(fade)
        addChild(Kind)
        
    }
    
    /*テーブル作成*/
    func maketable(){
        // 青い四角形を作る.
        let Rtable = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
        // 線の色を青色に指定.
        Rtable.strokeColor = UIColor.blue
        // 線の太さを2.0に指定.
        Rtable.lineWidth = 2.0
        // 四角形の枠組みの剛体を作る.
        Rtable.physicsBody = SKPhysicsBody(edgeLoopFrom: Rtable.frame)
        Rtable.position = CGPoint(x:self.width!/2 + 100,y:500)
        addChild(Rtable)
        
        let Ltable = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
        Ltable.strokeColor = UIColor.blue
        Ltable.lineWidth = 2.0
        Ltable.physicsBody = SKPhysicsBody(edgeLoopFrom: Ltable.frame)
        Ltable.position = CGPoint(x:self.width!/2 - 100,y:500)
        addChild(Ltable)

    
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
        if(active == true){
            //ただのタッチの場合は一番下にあるマテリアル削除
            Mate[sbango].removeFromParent()
            sbango = sbango+1
            active = false
        }
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
                    if(active == true){
                        //落ちるのをストップし、左の位置へ
                        Mate[sbango].removeAllActions()
                        Mate[sbango].moveLeft()
                        //左の配列に追加
                        self.Ltable.append(sbango)
                        addLeft(color:Mate[sbango].matekind)
                        sbango = sbango+1
                        active = false
                    }
                
                } else if(hantei < -15){
                    /*右にスライドした時の処理*/
                    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                        n.position = t.location(in: self)
                        n.strokeColor = SKColor.white
                        self.addChild(n)
                    }
                    if(active == true){
                        //落ちるのをストップし、右の位置へ
                        Mate[sbango].removeAllActions()
                        Mate[sbango].moveRight()
                        //右側のそれぞれの配列に追加
                        self.Rtable.append(sbango)
                        addRight(color:Mate[sbango].matekind)
                        sbango = sbango+1
                        active = false
                    }
                
                }else{
                    self.touchUp(atPoint: t.location(in: self))
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    /*ここまでタッチ処理*/

    //毎フレーム実行される
    override func update(_ currentTime: TimeInterval) {
      

        if rnumber == 3 {
            
            //kuniに組み合わせでできた国の名前を代入
            let kuni = judge(LorR:"R")
            addscore(kuni: kuni)
            
            //遅延処理(すぐ消えると違和感があるので)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tablereset(table:"R")
            }
            
            //右配列に格納している数をリセット
            rnumber=0

        }else if lnumber == 3 {
            let kuni = judge(LorR: "L")
            addscore(kuni: kuni)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tablereset(table:"L")
            }
            
            lnumber=0
        }
    }
    
    /*テーブルにあるマテリアルをリセット*/
    func tablereset(table:String){
        if(table == "R"){
            for var n1 in 0..<3 {
                print(n1)
                removeChildren(in: [Mate[Rtable[n1]]])
            }
            //右側テーブルの管理配列初期化
            Rtable.removeAll()
            //右側テーブルのスコア管理配列初期化
            Right.removeAll()
            
            //右側テーブルの初期位置リセット
            Material.rightn = 0.0
            
        
        }else if(table == "L"){
            for var n2 in 0..<3 {
                removeChildren(in: [Mate[Ltable[n2]]])
            }
        
            Left.removeAll()
            Ltable.removeAll()
            Material.leftn = 0.0
        }
    }
    
    func Upsbango(){
        print("**")
        self.sbango = self.sbango+1
        print(self.sbango)
    }
    
    
    
}
