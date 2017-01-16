//
//  GameScene.swift
//  sample as
//
//  Created by takahashi yuki on 2016/11/22.
//  Copyright © 2016年 takahashi yuki. All rights reserved.
/*
 マテリアルをテーブルに移動して、から削除、テーブルにスプライトを生成
 やること
 スコアの管理、背景をタッチしても消えないように,タイトルシーンの作成
 */
import SpriteKit
import GameplayKit
import UIKit

class BurgerScene: SKScene {
    
    
    let Rtable:SKShapeNode = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
    let Ltable:SKShapeNode = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
    
    //var baseNode:SKSpriteNode!
    
    //削除の為に管理させる配列
    var rightTable = [Int: SKSpriteNode]()
    var leftTable = [Int: SKSpriteNode]()
    //テーブルに配列するので
    var rightnode:SKSpriteNode!
    var leftnode:SKSpriteNode!
    //マテリアルのズレ保持
    static var rightn = CGFloat(0.0)
    static var leftn = CGFloat(0.0)
    
    //格納している数
    var rnumber = 0
    var lnumber = 0
    
    //scoreのラベル
    var scoreLabel:SKLabelNode?
    
    
    
    
    //タッチ開始座標
    var tpos:CGPoint!
    
    //タイマー使う際のおまじない
    var timer = Timer()
    
    
    //frameのサイズ簡略のため
    var width :CGFloat? = 0.0
    var height :CGFloat? = 0.0
    
    //score
    var score = 30
    
    
    override func didMove(to view: SKView) {
        
        //フレームの大きさ設定
        width = self.frame.size.width
        height = self.frame.size.height
        
        //背景
        /*baseNode = SKSpriteNode(imageNamed: "shooter-background")
         baseNode.position = CGPoint(x: width!*0.5, y: height!*0.5)
         baseNode.size = self.size
         self.addChild(baseNode)
         */
        
        //マテリアル生成タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.create), userInfo: nil, repeats: true)
        print(self.frame.size.width)
        
        
        
        //テーブルの作成
        maketable()
        
        
        //スコアラベルの生成
        let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = "30"
        scoreLabel.fontSize = 32
        scoreLabel.position = CGPoint(x: self.size.width-60, y: 40)
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        
        
        
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
        score -= 1
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
        let fade = SKAction.fadeOut(withDuration: 1.5)
        Kind.run(fade)
        addChild(Kind)
        
        setupScoreLabel(kuni: kuni)
        
    }
    
    /*スコアLabel*/
    func setupScoreLabel(kuni:String){
        
        let pointLabel = SKLabelNode()
        
        pointLabel.alpha = 0.5
        pointLabel.fontSize = 40.0
        pointLabel.position = CGPoint(x:width!/2,y:height!*2/5)
        let fade = SKAction.fadeOut(withDuration: 1.5)
        
        
        switch kuni {
        case "フランス": self.score += 10
        pointLabel.text = ("+10pt")
        case "イタリア":self.score += 8
        pointLabel.text = ("+8pt")
        case "ナイジェリア":self.score += 5
        pointLabel.text = ("+5pt")
        case "ペルー":self.score += 7
        pointLabel.text = ("+7pt")
        default:self.score += 0
        }
        
        pointLabel.run(fade)
        addChild(pointLabel)
        
    }
    
    /*テーブル作成*/
    func maketable(){
        // 青い四角形を作る.
        // 線の色を青色に指定.
        Rtable.strokeColor = UIColor.blue
        // 線の太さを2.0に指定.
        Rtable.lineWidth = 2.0
        // 四角形の枠組みの剛体を作る.
        Rtable.physicsBody = SKPhysicsBody(edgeLoopFrom: Rtable.frame)
        Rtable.position = CGPoint(x:self.width!/2 + 100,y:500)
        Rtable.alpha = 0.8
        addChild(Rtable)
        
        //let Ltable = SKShapeNode(rectOf: CGSize(width:150.0, height:150.0))
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
        let node = self.atPoint(pos)
        //ただのタッチ,マテリアル削除
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
            
            /*左にスライドした時の処理*/
            if(hantei>15){
                //落ちるのストップ
                node.removeAllActions()
                //LeftTableに入れる
                if let color = node.name {
                    print("lnumber:\(lnumber),color:\(color)")
                    LeftTable().addLeftTable(color:color, number: lnumber)
                    //左tableへ移動、移動後フェードアウト
                    let leftmove = SKAction.move(to: CGPoint(x:width!/2 - 120 + GameScene.leftn,y:500.0),duration: 0.1)
                    let FadeOutAction = SKAction.fadeOut(withDuration: 1.0)
                    // leftmove,FadeOutを順番に実行
                    let sequenceAction = SKAction.sequence([leftmove,FadeOutAction])
                    
                    //テーブルにマテリアルを配置
                    updateLeft(color:color)
                    
                    //次に入る位置調整
                    GameScene.leftn += 20.0
                    //lnumberをインクリメント
                    lnumber += 1
                    
                    //移動、フェードアウトを実行
                    node.run(sequenceAction)
                }
                
                /*右にスライドした時の処理*/
            } else if(hantei < -15){
                node.removeAllActions()
                //RighttTableに入れる
                if let color = node.name {
                    
                    RightTable().addRightTable(color:color, number: rnumber)
                    let rightmove = SKAction.move(to: CGPoint(x:width!/2 + 80 + GameScene.rightn,y:500.0), duration: 0.1)
                    let FadeOutAction = SKAction.fadeOut(withDuration: 1.0)
                    let sequenceAction = SKAction.sequence([rightmove,FadeOutAction])
                    updateRight(color:color)
                    rnumber += 1
                    GameScene.rightn += 20.0
                    node.run(sequenceAction)
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
        
        self.scoreLabel?.text = "\(self.score)"
        
        if rnumber == 3 {
            
            //kuniに組み合わせでできた国の名前を代入
            let kuni = RightTable().Rcheck()
            addscore(kuni:kuni)
            
            //遅延処理(すぐ消えると違和感があるので)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tablereset(table:"R")
            }
            
            //右配列に格納している数をリセット
            rnumber=0
            
        }
        
        if lnumber == 3 {
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
            for i in 0...2 {
                if let removenode = self.rightTable[i]{
                    //テーブル上のマテリアルを削除
                    removenode.removeFromParent()
                    //配列も削除
                    self.rightTable.removeValue(forKey: i)
                }
            }
            RightTable().Rreset()
            
        }else if(table == "L"){
            LeftTable().Lreset()
            GameScene.leftn = 0.0
            for i in 0...2 {
                if let removenode = self.leftTable[i]{
                    removenode.removeFromParent()
                    self.leftTable.removeValue(forKey: i)
                }
            }
        }
        LeftTable().Lreset()
    }
    
    //stringできた色をCIColorに変換
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
    
    //RightTableに配置
    func updateRight(color:String){
        let rightnode = SKSpriteNode()
        rightnode.size = CGSize(width:20.0,height:80.0)
        rightnode.color = UIColor(ciColor:(whatColor(color: color)))
        rightnode.position = CGPoint(x:width!/2 + 80 + GameScene.rightn,y:500.0)
        self.rightTable[rnumber] = rightnode
        self.addChild(rightnode)
    }
    
    //LeftTablleに配置
    func updateLeft(color:String){
        let leftnode = SKSpriteNode()
        leftnode.size = CGSize(width:20.0,height:80.0)
        leftnode.color = UIColor(ciColor:(whatColor(color: color)))
        leftnode.position = CGPoint(x:width!/2 - 120 + GameScene.leftn,y:500.0)
        self.leftTable[lnumber] = leftnode
        self.addChild(leftnode)
    }
    
    
    
    
    
    
}
