//
//  HpBar.swift
//  sample as
//
//  Created by takahashi yuki on 2017/01/16.
//  Copyright © 2017年 takahashi yuki. All rights reserved.
//

import Foundation
import SpriteKit

class HpBar: SKCropNode {
    
    override init() {
        super.init()
        
        let sprite = SKSpriteNode(color: SKColor.red, size:CGSize(width:300,height:20))
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        let maskSprite = SKSpriteNode(color: SKColor.red, size:CGSize(width:300,height:20))
        maskSprite.anchorPoint = CGPoint(x: 0, y: 0)
        self.maskNode = maskSprite
        
        addChild(sprite)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初期値設定メソッド (0.0 〜 1.0)
    func setProgress(progress: CGFloat) {
        self.maskNode?.xScale = progress
    }
    
    // プログレスバーの数値を増やすメソッド
    func updateProgress(progress:CGFloat){
        self.maskNode?.xScale += progress
    }
}
