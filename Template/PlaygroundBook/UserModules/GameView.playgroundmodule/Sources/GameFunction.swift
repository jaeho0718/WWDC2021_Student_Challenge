//
//  GameFunction.swift
//  PlaygroundBook
//
//  Created by Lee Jaeho on 2021/04/10.
//

import Foundation
import PlaygroundSupport
import UIKit

let viewController = GameViewController() //viewCotroller for game


/// To make Game, this function sould be used.
/// After all settings about game (like sound,score_Show) is done, call this function
public func GameInit(){
    //set playgroundLive view as gameView
    PlaygroundPage.current.liveView = viewController
    PlaygroundPage.current.needsIndefiniteExecution = true
}

/// AddBlock
    /// - parameter to : position that you want to put the box
    /// - parameter delay : delay. If delay is 10, Block appears after 10seconds. The value should be Double.
public func AddBlock(to TapName : Int,delay:TimeInterval = 0){
    //Make Block
    viewController.AddBlock(to: TapName, delay: delay)
}

/// return random Tap position ( retrun type is Intiger )
public func randomTap()->Int{
    //return random position that block will appear
    return Int.random(in: 1...9)
}

/// return randomDelayTime
    /// - parameter from : random start point
    /// - parameter to : random end point
public func randomDelay(from : Int,to:Int)->TimeInterval{
    return Double.random(in: Double(from)...Double(to))
}

/// set startDelay
    /// - parameter delay : value should be Double
public func setStartDelay(_ delay:TimeInterval){
    //set StartDelay.
    //If you set delay is 10, game starts after 10seconds
    viewController.setStartDelay(delay)
}

public func playSound(_ play : Bool){
    //If play is true, gamesound(bgm) is played.
    viewController.playSound(play)
}

/// set scoreLabel
    /// - parameter score: score
    /// - parameter comment: score comment
public func setScoreLabel(score:String,comment:String)->(String,String){
    //To set scoreLabel, use this function with setEndingScene function.
    return (score,comment)
}

/// show Score on screen
    /// - parameter show: If show is false, score in screen disappear
public func showScore(_ show:Bool){
    viewController.showScore(show)
}

/// To judge score, use this function
/// - parameter function: put if-statement to judge score. use with getScoreLabel function
public func setEndingScene(_ function: @escaping (Int)->(String,String)){
    viewController.settingOfEndScene(function)
}

/// Show particle effect on screen.
/// - parameter show: true-show particle, false-not show particle
public func showParticle(_ show:Bool){
    viewController.showParticle(show)
}
