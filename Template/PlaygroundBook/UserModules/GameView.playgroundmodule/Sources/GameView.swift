//
//  GameView.swift
//  BookCore
//
//  Created by Lee Jaeho on 2021/04/05.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

class GameViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SKView()
        view.presentScene(GameScene())
        self.view = view
    }
}

