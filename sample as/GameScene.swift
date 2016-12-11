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
    
    
    let Rtable:SKShapeNode = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
    
    //マテリアルのズレ保持
    static var rightn = CGFloat(0.0)
    static var leftn = CGFloat(0.0)
    
    //格納している数
    var rnumber = 0
    var lnumber = 0
    
    
    //タッチ開始座標
    var tpos:CGPoint!
    
    //タイマー使う際のおまじない
    var timer = Timer()

    
    //frameのサイズ簡略のため
    var width :CGFloat? = 0.0
    var height :CGFloat? = 0.0
    
    //score
    var score = 0

    
    override func didMove(to view: SKView) {
 
    
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
        mate.name = mate.matekind
        //移動設定
        let move = SKAction.moveBy(x: 0, y: -self.size.height, duration: 4)
        mate.run(move)
        self.addChild(mate)
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
        
        setupScoreLabel()
        
    }
    
    /*スコアLabel*/
    func setupScoreLabel(){
        
        let scoreLabel = SKLabelNode(text:"\(score)")
        scoreLabel.position = CGPoint(x:self.width!/2,y:self.height!/2)
        score += 8
        addChild(scoreLabel)

    
    
    }
    
    /*テーブル作成*/
    func maketable(){
        // 青い四角形を作る.
        //Rtable = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
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
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
  
    }
    
    func touchUp(atPoint pos : CGPoint) {
        var node = self.atPoint(pos)
            //ただのタッチのマテリアル削除
            node.removeFromParent()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
                //タッチした場所ータッチし終わった場所で判定
                let hantei = Int(tpos.x)-Int(epos.x)
            
                //タッチした座標にいたマテリアルを処理対象　nodeに代入
                let node = self.atPoint(CGPoint(x:tpos.x,y:epos.y))
        
                /*右にスライドした時の処理*/
                if(hantei>15){
                    print("左")
                    //落ちるのストップ
                    node.removeAllActions()
                    
                    //LeftTableに入れる
                    LeftTable().addLeftTable(color:node.name!, number: lnumber)
                    //左tableへ移動
                    let left = SKAction.move(to: CGPoint(x:width!/2 - 120 + GameScene.leftn,y:500.0),duration: 0.1)
                    GameScene.leftn += 20.0
                    lnumber += 1
                    node.run(left)
                        
                /*右にスライドした時の処理*/
                } else if(hantei < -15){
                    print("右")
                    node.removeAllActions()
                    //RighttTableに入れる
                    if let color = node.name {
                    RightTable().addRightTable(color:color, number: rnumber)
                    let right = SKAction.move(to: CGPoint(x:width!/2 + 80 + GameScene.rightn,y:500.0), duration: 0.1)
                    
                    let newnode = SKSpriteNode(texture:nil)
                    
                    newnode.color = UIColor(ciColor:(whatColor(color: color)))
                    newnode.position = CGPoint(x:width!/2 + 80 + GameScene.rightn,y:500.0)
                    Rtable.addChild(newnode)
                    
                    GameScene.rightn += 20.0
                    node.run(right)
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
            let kuni = RightTable().Rcheck()
            addscore(kuni: kuni)
            
            //遅延処理(すぐ消えると違和感があるので)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tablereset(table:"R")
            }
            
            //右配列に格納している数をリセット
            rnumber=0

        }else if lnumber == 3 {
            let kuni = LeftTable().Lcheck()
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
            
            //右側テーブルリセット
            RightTable().Rreset()
            //右側テーブルの初期位置リセット
            GameScene.rightn = 0.0
            Rtable.removeAllChildren()
            
        
        }else if(table == "L"){
            LeftTable().Lreset()
            GameScene.leftn = 0.0
        }
    }
    
    func whatColor(color:String)->CIColor{
        var iro = CIColor.clear()
        switch color{
        case "red":   iro = CIColor.red()
        case "blue":  iro = CIColor.blue()
        case "green": iro = CIColor.green()
        case "white": iro = CIColor.white()
        default:break
        
        }
        return iro
    
    }
    
 
    
    
    
}
