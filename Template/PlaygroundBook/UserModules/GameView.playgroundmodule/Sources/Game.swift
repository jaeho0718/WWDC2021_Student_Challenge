//
//  Game.swift
//  BookCore
//
//  Created by Lee Jaeho on 2021/04/07.
//
import Foundation
import UIKit
import SpriteKit
import GameplayKit
import PlaygroundSupport

public class GameViewController : UIViewController{
    
    let scene = GameScene(Scenesize: CGSize(width: 300, height: 400))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let view = SKView(frame:UIScreen.main.bounds)
        self.scene.scaleMode = .aspectFit
        view.presentScene(self.scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        //view.showsPhysics = true
        self.view = view
    }
}

extension GameViewController{
    
    func setTimer(interval: TimeInterval, function:@escaping () -> Void){
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            function()
        }
        timer.tolerance = interval * 0.2
    }
    
    public func AddBlock(to TapName:Int,delay:TimeInterval = 0){
        setTimer(interval:self.scene.startDelay+delay, function: {
            self.scene.AddBlock(to: TapName)
        })
    }
    
    public func setStartDelay(_ delay : TimeInterval){
        scene.setStartDelay(delay)
    }
    
    public func playSound(_ play:Bool){
        scene.playSound(play)
    }
    
    public func showScore(_ show:Bool){
        scene.ScoreAppear(show)
    }
    
    public func settingOfEndScene(_ function: @escaping (Int)->(String,String)){
        scene.setendscore = function
    }
    
    public func showParticle(_ show:Bool){
        scene.showParticle(show)
    }
}

