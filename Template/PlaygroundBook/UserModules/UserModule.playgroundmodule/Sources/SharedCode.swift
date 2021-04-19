//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An empty, user-editable source file. Part of the "UserModule" user module.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Button : SKSpriteNode{
    var button : SKSpriteNode
    var action : (Int)->()
    var index : Int
    
    init(ButtonNode:SKSpriteNode,action:@escaping(Int)->(),index:Int){
        self.button = ButtonNode
        self.action = action
        self.index = index
        super.init(texture: nil, color: UIColor.clear, size: self.button.size)
        isUserInteractionEnabled = true
        addChild(self.button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.alpha = 0.75
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first! as UITouch
        let location : CGPoint = touch.location(in: self)
        if button.contains(location){
            button.alpha = 0.75
        }else{
            button.alpha = 1.0
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first! as UITouch
        let location : CGPoint = touch.location(in: self)
        
        if button.contains(location){
            action(index)
        }
        
        button.alpha = 1.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.alpha = 1.0
    }
    
}
