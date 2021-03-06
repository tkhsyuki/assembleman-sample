//
//  GameScene.swift
//  sample as
//
//  Created by takahashi yuki on 2016/11/22.
//  Copyright © 2016年 takahashi yuki. All rights reserved.
/*
マテリアルをテーブルに移動して、から削除、テーブルにスプライトを生成
 やること
    背景をタッチしても消えないように,ライフ管理、各パーツをクラス化してコードを見やすく
*/
import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    let Rtable:SKShapeNode = SKShapeNode(rectOf: CGSize(width:100.0, height:100.0))
    let Ltable:SKShapeNode = SKShapeNode(rectOf: CGSize(width:100.0, height:100.0))
    
    var slime:SKSpriteNode?
    
    // 落下判定用シェイプ
    var lowestShape:SKShapeNode?
    var attack1:SKSpriteNode?
    
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
    
    //enemylife
    var enemylife = 100.0

    var progressBar = HpBar()
    
    override func didMove(to view: SKView) {
        
        /*BGM
        let sound = SKAction.playSoundFileNamed("5629.mp3", waitForCompletion:true)
        let repeatForever = SKAction.repeatForever(sound)
        self.run(repeatForever)
        */
        
        //フレームの大きさ設定
        width = self.frame.size.width
        height = self.frame.size.height
        
        //マテリアル生成タイマー
       self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.create), userInfo: nil, repeats: true)
        //てきの攻撃タイマー
        self.timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.enemyAttack), userInfo: nil, repeats: true)
        
        //テーブル,ダメージ判定用シェイプの作成
        makesetup()
        
        //スコアラベルの生成
        let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = "30"
        scoreLabel.fontSize = 32
        scoreLabel.position = CGPoint(x: self.size.width-60, y: 40)
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel

        //モンスター生成
        self.slime = SKSpriteNode(imageNamed:"slim")
        self.slime?.position = CGPoint(x:width!/2,y:height!*6/7+20)
        self.slime?.size = CGSize(width:100,height:100)
        self.addChild(slime!)
        
       self.makebar()
       
    }
   
    /*マテリアル生成*/
    func create(){
        let mate = Material()
        
        //0~4のランダムな整数生成
        let rndint = CGFloat(arc4random_uniform(4))
        
        //こっちじゃないとフレーム指定できない?のでこちらでポジション指定
        let framew = self.frame.size.width
        let frameh = self.frame.size.height
        mate.position = CGPoint(x:framew/5*(rndint+1),y:frameh*2/3 - 40.0)
        mate.name = mate.matekind
        //移動設定
        let move = SKAction.moveBy(x: 0, y: -self.size.height, duration: 4)
        mate.run(move)
        //score -= 1
        self.addChild(mate)
    }
    
    /*barsetup*/
    func makebar(){
        // プログレスバーを追加(ダメージ幅)
        self.addChild(progressBar)
        progressBar.setProgress(progress: 0.0) // 初期値
        progressBar.position = CGPoint(x: 30, y: self.frame.height-30)
        progressBar.zPosition = 20
        // 背景バーよりレイヤーを前に
        
        // プログレスバー(現在HP幅)を追加
        let backgroundBar = SKSpriteNode(color: UIColor.green, size:CGSize(width:300,height:20))
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: 30, y: self.frame.height-30)
        
        self.addChild(backgroundBar)
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
    
    /*敵の攻撃*/
    func enemyAttack(){
        let ran2 = DispatchTime(uptimeNanoseconds: UInt64(arc4random_uniform(3)))
        // 赤色の長方形のShapeNodeを作成.
        let redRect = SKShapeNode(rectOf:CGSize(width:self.width!,height:self.height!))
        // 座標を中心に指定(ShapeNodeの中心の座標になる).
        redRect.position = CGPoint(x:self.width!/2,y:self.height!/2)
        // 塗りつぶしの色を赤色に指定.
        redRect.fillColor = UIColor.red
        //効果音の再生
        let sound = SKAction.playSoundFileNamed("slap1.mp3", waitForCompletion:true)
        // 指定した回転値まで拡大させるアクション.
        let ScaleBigAction = SKAction.scale(to: 3.0, duration: 0.3)
        // 指定した値まで拡大させるアクション.
        let ScalebackAction = SKAction.scale(to: 1.0, duration: 0.3)
        // フェードアウトさせるアクションを作る.
        let fadeOAction = SKAction.fadeOut(withDuration: 0.3)
        let fadeIAction = SKAction.fadeIn(withDuration: 0.3)
        // 同時実行するグループアクションを作る.
        let group1Action = SKAction.group([ScaleBigAction,fadeOAction])
        let group2Action = SKAction.group([ScalebackAction,fadeIAction])
        //逐次実行
        let sequenceAction = SKAction.sequence([group1Action,sound,group2Action,])
        //遅延処理(攻撃時間ランダムのため)
        DispatchQueue.main.asyncAfter(deadline:ran2) {
            self.slime?.run(sequenceAction)
            DispatchQueue.main.asyncAfter(deadline:DispatchTime(uptimeNanoseconds: UInt64(3))) {
                print("Attacked")
                self.score -= 5
            }

        }
        
    }
    
    
    /*スコアLabel(ダメージ処理)*/
    func setupScoreLabel(kuni:String){
        
        let pointLabel = SKLabelNode()
        //ランダムな変数0~4の変数を生成
        let rndintX = CGFloat(arc4random_uniform(5))
        let rndintY = CGFloat(arc4random_uniform(5))
        
        pointLabel.alpha = 1.0
        pointLabel.fontSize = 50.0
        pointLabel.fontColor = UIColor.red
        pointLabel.position = CGPoint(x:width!/2+30 - rndintX*10,y:height!*6/7+50 - rndintY*10)
        pointLabel.zPosition = 30
        let fade = SKAction.fadeOut(withDuration: 3.0)
        
        //Hpバーを減らす量
        var setDamage = 0.0
        
        //サウンド情報保持
        let damagesound = SKAction.playSoundFileNamed("punch-high1.mp3", waitForCompletion:true)
        
        switch kuni {
            case "フランス": self.score += 10//スコア増加
                            pointLabel.text = ("10")//ダメージ量表示
                            setDamage = 0.1//バーに与えるダメージを設定
                            self.run(damagesound)
            
            case "イタリア":self.score += 8
                            pointLabel.text = ("8")
                            setDamage = 0.08
                            self.run(damagesound)
            
            case "ナイジェリア":self.score += 5
                            pointLabel.text = ("5")
                            setDamage = 0.05
                            self.run(damagesound)
            
            case "ペルー":self.score += 7
                            pointLabel.text = ("7")
                            setDamage = 0.07
                            self.run(damagesound)
            
            default:self.score += 0
        }
        self.progressBar.updateProgress(progress: CGFloat(setDamage))
        self.enemylife -= Double(setDamage) * 100.0
        
        
        pointLabel.run(fade)
        addChild(pointLabel)
        
    }
    
    /*テーブル、判定用作成*/
    func makesetup(){
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
            //self.progressBar.updateProgress(progress: 0.01)
        
        
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
                    LeftTable().addLeftTable(color:color, number: lnumber)
                    //左tableへ移動、移動後フェードアウト
                    let leftmove = SKAction.move(to: CGPoint(x:width!/2 - 120 + GameScene.leftn,y:500.0),duration: 0.1)
                    let scaleAction = SKAction.scaleX(by: 0.5, y: 1.0, duration: 0.1)
                    let FadeOutAction = SKAction.fadeOut(withDuration: 0.5)
                    // leftmove,FadeOutを順番に実行
                    let sequenceAction = SKAction.sequence([leftmove,scaleAction,FadeOutAction])
                        
                    //テーブルにマテリアルを配置
                    updateLeft(color:color)
                    //lnumberをインクリメント
                    lnumber += 1
                    //次に入る位置調整
                    GameScene.leftn += 20.0
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
                    let scaleAction = SKAction.scaleX(by: 0.5, y: 1.0, duration: 0.1)
                    let FadeOutAction = SKAction.fadeOut(withDuration: 0.5)
                    let sequenceAction = SKAction.sequence([rightmove,scaleAction,FadeOutAction])
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
        
        if(self.score < 1){
            
            // ゲームオーバー画面のシーンを作成する
            let scene = self.createImageScene(imageName: "gameover.jpeg")
            // クロスフェードトランジションを適用しながらシーンを移動する
            let transition = SKTransition.crossFade(withDuration: 1.0)
            self.view?.presentScene(scene, transition: transition)
            self.score = 30
            self.progressBar = HpBar()
        }
        
        if(enemylife < 1){
            // ゲームクリア画面のシーンを作成する
            let scene = self.createImageScene(imageName: "gameclear.jpg")
            // クロスフェードトランジションを適用しながらシーンを移動する
            let transition = SKTransition.crossFade(withDuration: 1.0)
            self.view?.presentScene(scene, transition: transition)
            self.score = 30
            self.progressBar = HpBar()
        
        
        }
      
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
    
    // 一枚絵を表示するシーンを作成するメソッド
    func createImageScene(imageName: String) -> SKScene {
        // シーンのサイズはGameSceneに合わせる
        let scene = TouchScene(size: self.size)
        // スプライトをシーン中央に貼り付ける
        let sprite = SKSpriteNode(imageNamed: imageName)
        sprite.size = scene.size
        sprite.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.5)
        scene.addChild(sprite)
        
        return scene
    }


    
 
    
    
    
}
