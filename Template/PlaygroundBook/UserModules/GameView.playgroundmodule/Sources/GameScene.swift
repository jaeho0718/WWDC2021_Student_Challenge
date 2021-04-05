//
//  GameScene.swift
//  PlaygroundBook
//
//  Created by Lee Jaeho on 2021/04/05.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameScene : SKScene{
    override func didMove(to view: SKView) {
        let rectangle = SKLabelNode(text: "Hello")
        scene?.addChild(rectangle)
        //setEnviorment()
    }
    
    func setEnviorment(){
        let background = SKSpriteNode(imageNamed: "Background.png")
        scene?.addChild(background)
    }
    
}
