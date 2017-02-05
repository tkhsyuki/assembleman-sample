//
//  TouchScene.swift
//  sample as
//
//  Created by takahashi yuki on 2017/02/05.
//  Copyright © 2017年 takahashi yuki. All rights reserved.
//

import Foundation
import SpriteKit

class TouchScene: SKScene {
    // 画面タッチ時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // フリップトランジション
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        
        // GameSceneを初期化する
        let scene = GameScene()
        scene.scaleMode = .aspectFill
        scene.size = self.size
        
        // トランジションを適用しながらGameSceneに遷移する
        self.view?.presentScene(scene, transition: transition)
    }
}
