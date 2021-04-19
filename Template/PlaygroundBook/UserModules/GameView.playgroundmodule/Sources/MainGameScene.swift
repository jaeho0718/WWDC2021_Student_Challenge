//
//  MainGameScene.swift
//  PlaygroundBook
//
//  Created by Lee Jaeho on 2021/04/09.
//

import Foundation
import SpriteKit
import UIKit
import AVFoundation

public class GameScene : SKScene,SKPhysicsContactDelegate{
    
    var title_size_width : CGFloat
    var title_size_height : CGFloat
    var title_anchorPoint_x : CGFloat
    var title_anchorPoint_y : CGFloat
    var button_size_width : CGFloat
    var button_size_height : CGFloat
    var launchPad_Size : CGSize
    
    var launchPad : LaunchPad!
    
    var sound : AVAudioPlayer?
    
    var SoundName : String?
    
    var SoundPlay : Bool = true
    
    var startDelay : Double = 3.0
    
    var showscore : Bool = true
    
    var ScoreLabel : SKLabelNode!
    
    var ScoreName : String?
    
    var ScoreComment : String?
    
    var score : Int = 0 {
        didSet {
            ScoreLabel.text = "SCORE : \(score)"
        }
    }
    
    var playTimeLabel : SKLabelNode!
    
    var playTime : TimeInterval = 0 {
        didSet {
            playTimeLabel.text = "TIME : \(floor(playTime)) / \(sound?.duration ?? 0)"
        }
    }
    
    var isEnd : Bool = false
    
    var endscene : EndNode?
    
    var setendscore : (Int)->(String,String) = {_ in return ("","")}
    
    var showparticle : Bool = false
    
    init(Scenesize:CGSize) {
        self.title_size_width = Scenesize.width/5*4
        self.title_size_height = Scenesize.height/5*4
        self.title_anchorPoint_x = (Scenesize.width-title_size_width)/2
        self.title_anchorPoint_y = 20
        self.button_size_width = (Scenesize.width/5*4)/3
        self.button_size_height = (Scenesize.height/5*4)/10
        let width = Scenesize.width > Scenesize.height ? Scenesize.width/2:Scenesize.height/2
        self.launchPad_Size = CGSize(width: width, height: width)
        super.init(size: Scenesize)
        self.launchPad = LaunchPad(launchPad_Size, ScreenSize: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        setEnviorment()
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        //Check contact.
        var Block = SKPhysicsBody()
        var Touch = SKPhysicsBody()
        if contact.bodyA.node?.name == "Block" {
            Block = contact.bodyA
            Touch = contact.bodyB
        }else {
            Block = contact.bodyB
            Touch = contact.bodyA
        }
        if Block.node?.name == "Block" && Touch.node?.name == "touch"{
            if self.showscore{
                self.score += 1
            }
            Block.node?.removeFromParent()
        }
    }
    
    public func setEnviorment(){
        //Add Game sound
        if self.SoundPlay{
            setSound("OneStepCloser")
            showSoundInfo()
        }
        //Add Game Background
        Background()
        //Add Particle
        if showparticle{
            Particle()
        }
        
        //Add LunchPad
        let launchpad = self.launchPad.makeTouchPad()
        self.addChild(launchpad)
        //Add Score
        if showscore{
            self.showScore()
        }
    }
    
    public func Particle(){
        guard let star = SKEmitterNode(fileNamed: "Snow") else {return}
        
        star.position = CGPoint(x: 0, y: size.height)
        star.zPosition = Layer.particle
        self.addChild(star)
    }
    
    public func showSoundInfo(){
        playTimeLabel = SKLabelNode()
        playTimeLabel.fontSize = 10
        playTimeLabel.text = "0/0"
        playTimeLabel.position = CGPoint(x: size.width/2, y: 30)
        playTimeLabel.zPosition = Layer.touch
        self.addChild(playTimeLabel)
    }

    public func Background(){
        let background = SKSpriteNode(imageNamed: "background.png")
        background.size = CGSize(width: size.width, height: size.height)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.background
        self.addChild(background)
    }
    
    
    public func AddBlock(to TapName : Int){
        let block = self.launchPad.AddBlock(to: TapName)
        self.addChild(block)
        self.launchPad.BlockAnimation(block)
    }
    
    public func setSound(_ soundName : String,type : String = ".mp3"){
        self.SoundName = soundName + type
        let path = Bundle.main.path(forResource: self.SoundName, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            self.sound = try AVAudioPlayer(contentsOf: url)
            setTimer(interval: self.startDelay, function: {
                self.sound?.play()
            })
            setTimer(interval: self.sound?.duration ?? 0, function: {
                self.isEnd = true
            })
        }catch{
            
        }
    }
    
    //User setting
    
    public func setStartDelay(_ delay : TimeInterval){
        self.startDelay = delay
    }
    
    public func playSound(_ play : Bool){
        self.SoundPlay = play
    }
    
    public func ScoreAppear(_ show:Bool){
        self.showscore = show
    }
    
    public func showParticle(_ show:Bool){
        showparticle = show
    }
    
    public func showScore(){
            self.ScoreLabel = SKLabelNode()
            self.ScoreLabel.text = "SCORE : 0"
            let startHeight : CGFloat = 100
            self.ScoreLabel.fontSize = 20
            self.ScoreLabel.position = CGPoint(x: (self.launchPad?.launchPad_position_x ?? 0)+self.launchPad_Size.width/2, y: startHeight+self.launchPad_Size.height+10)
            self.ScoreLabel.zPosition = 8
            self.addChild(self.ScoreLabel)
    }
    
    func setTimer_repeat(interval: TimeInterval, function:@escaping () -> Void) -> Timer {
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            function()
        }
        timer.tolerance = interval * 0.2
        
        return timer
    }
    
    func setTimer(interval: TimeInterval, function:@escaping () -> Void){
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            function()
        }
        timer.tolerance = interval * 0.2
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            guard let touch = self.launchPad.showTouch(location) else {return}
            self.addChild(touch)
            self.launchPad.touchAnimation(touch)
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if self.SoundPlay{
            playTime = sound?.currentTime ?? 0
        }
        if isEnd{
            //If sound is end, Game is end
            //ScoreLabel.text = "Good"
            let results = setendscore(self.score)
            self.ScoreName = results.0
            self.ScoreComment = results.1
            
            if let scorename = self.ScoreName{
                if let scorecomment = self.ScoreComment{
                    self.endscene = EndNode(scorename, screensize: self.size)
                    let nodes = self.endscene!.showScore(scorecomment)
                    self.addChild(nodes[0])
                    self.addChild(nodes[1])
                }
            }
            isEnd = false
        }
    }
}


class LaunchPad : SKSpriteNode{
    var ScreenSize : CGSize
    var PadSize : CGSize
    var launchPad_position_x : CGFloat
    var launchPad_position_y : CGFloat
    let padWidth : CGFloat
    let padHeight : CGFloat
    let buttonwidth : CGFloat
    var touchNode : SKShapeNode
    var Block : [SKSpriteNode] = []
    
    init(_ size:CGSize,ScreenSize:CGSize) {
        self.ScreenSize = ScreenSize
        self.PadSize = size
        self.launchPad_position_x = (self.ScreenSize.width-size.width)/2
        self.launchPad_position_y = 100
        self.padWidth = size.width
        self.padHeight = size.height
        self.buttonwidth = padWidth/3
        self.touchNode = SKShapeNode.init(rectOf: CGSize.init(width: self.buttonwidth-40, height: self.buttonwidth-40), cornerRadius: 5)
        touchNode.strokeColor = UIColor.white
        touchNode.lineWidth = 2
        touchNode.zPosition = Layer.touch
        touchNode.name = "touch"
        touchNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.buttonwidth-40, height: self.buttonwidth-40),center:CGPoint(x: 0.5, y: 0.5))
        touchNode.physicsBody?.categoryBitMask = BitMask.Touch
        touchNode.physicsBody?.contactTestBitMask = BitMask.Block
        touchNode.physicsBody?.collisionBitMask = BitMask.Block
        touchNode.physicsBody?.affectedByGravity = false
        touchNode.physicsBody?.isDynamic = false
        
        Block.append(SKSpriteNode(imageNamed: "TapColor1"))
        Block.append(SKSpriteNode(imageNamed: "TapColor2"))
        Block.append(SKSpriteNode(imageNamed: "TapColor3"))
        for each in Block{
            each.zPosition = Layer.block
            each.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            each.size = CGSize(width: self.PadSize.width/4, height: self.PadSize.width/4)
            each.name = "Block"
            
            each.physicsBody = SKPhysicsBody(rectangleOf: each.size,center: each.anchorPoint)
            each.physicsBody?.affectedByGravity = false
            each.physicsBody?.isDynamic = true
            each.physicsBody?.categoryBitMask = BitMask.Block
            each.physicsBody?.contactTestBitMask = BitMask.Touch
            each.physicsBody?.collisionBitMask = BitMask.Touch
        }
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeTouchPad()->SKSpriteNode{
        let LaunchPad = SKSpriteNode(imageNamed: "LaunchPad")
        LaunchPad.size = self.size
        LaunchPad.anchorPoint = CGPoint(x: 0, y: 0)
        LaunchPad.position = CGPoint(x: self.launchPad_position_x, y: self.launchPad_position_y)
        LaunchPad.zPosition = Layer.launchpad
        return LaunchPad
    }
    
    func BlockAnimation(_ Block: SKSpriteNode){
        var Actions = [SKAction]()
        Block.alpha = 0
        Actions.append(SKAction.fadeIn(withDuration: 0.2))
        Actions.append(SKAction.wait(forDuration: 1))
        Actions.append(SKAction.fadeOut(withDuration: 0.2))
        Actions.append(SKAction.removeFromParent())
        Block.run(SKAction.sequence(Actions))
    }
    
    func AddBlock(to TapName : Int)->SKSpriteNode{
        //Detect Collision
        let random =  Int.random(in: 0...2)
        let padWidth = self.PadSize.width
        let padHeight = self.PadSize.height
        let buttonwidth = padWidth/3
        
        if let block = self.Block[random].copy() as? SKSpriteNode{
            switch TapName {
            case 1:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+padHeight-buttonwidth/2)
            case 2:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+padHeight-buttonwidth/2)
            case 3:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+padHeight-buttonwidth/2)
            case 4:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
            case 5:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
            case 6:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
            case 7:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+buttonwidth/2)
            case 8:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+buttonwidth/2)
            case 9:
                block.position =  CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+buttonwidth/2)
            default:
                block.position =  CGPoint(x: -100, y: -100)
            }
            return block
        }else{
            return SKSpriteNode(imageNamed: "TapColor1")
        }
        
        
    }
    
    func showTouch(_ position : CGPoint)->SKShapeNode?{
        
        if let touch = touchNode.copy() as? SKShapeNode {
        
        let touchName = self.getTouchTapName(position)
        
        switch touchName {
        case "Tap1":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+padHeight-buttonwidth/2)
        case "Tap2":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+padHeight-buttonwidth/2)
        case "Tap3":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+padHeight-buttonwidth/2)
        case "Tap4":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
        case "Tap5":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
        case "Tap6":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+padHeight-buttonwidth/2*3)
        case "Tap7":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2, y: self.launchPad_position_y+buttonwidth/2)
        case "Tap8":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*3, y: self.launchPad_position_y+buttonwidth/2)
        case "Tap9":
            touch.position = CGPoint(x: self.launchPad_position_x+buttonwidth/2*5, y: self.launchPad_position_y+buttonwidth/2)
        default:
            touch.position = CGPoint(x: -100 , y: -100)
            break
        }
        
        return touch
            
        }else{
            return nil
        }
    }
    
    func touchAnimation(_ touch : SKShapeNode){
        var touchActions = [SKAction]()
        touchActions.append(SKAction.fadeIn(withDuration: 0.1))
        touchActions.append(SKAction.wait(forDuration: 0.2))
        touchActions.append(SKAction.fadeOut(withDuration: 0.1))
        touchActions.append(SKAction.removeFromParent())
        touch.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        touch.run(SKAction.sequence(touchActions))
    }
    
    func getTouchTapName(_ position : CGPoint)->String{
        let x = position.x
        let y = position.y
        
        if y>self.launchPad_position_y+padHeight/3*2 && self.launchPad_position_y+padHeight > y{
            //1Columns
            if self.launchPad_position_x < x && self.launchPad_position_x+buttonwidth > x{
                //(1,0)
                return "Tap1"
            }else if self.launchPad_position_x+buttonwidth < x && self.launchPad_position_x+buttonwidth*2 > x{
                //(1,1)
                return "Tap2"
            }else if self.launchPad_position_x+buttonwidth*2 < x && self.launchPad_position_x+buttonwidth*3 > x{
                //(1,2)
                return "Tap3"
            }
            
        }else if y>self.launchPad_position_y+padHeight/3 && self.launchPad_position_y+padHeight/3*2>y{
            //2Columns
            if self.launchPad_position_x < x && self.launchPad_position_x+buttonwidth > x{
                //(2,0)
                return "Tap4"
            }else if self.launchPad_position_x+buttonwidth < x && self.launchPad_position_x+buttonwidth*2 > x{
                //(2,1)
                return "Tap5"
            }else if self.launchPad_position_x+buttonwidth*2 < x && self.launchPad_position_x+buttonwidth*3 > x{
                //(2,2)
                return "Tap6"
            }
        }else if y>self.launchPad_position_y && self.launchPad_position_y+padHeight/3>y{
            //3columns
            if self.launchPad_position_x < x && self.launchPad_position_x+buttonwidth > x{
                //(3,0)
                return "Tap7"
            }else if self.launchPad_position_x+buttonwidth < x && self.launchPad_position_x+buttonwidth*2 > x{
                //(3,1)
                return "Tap8"
            }else if self.launchPad_position_x+buttonwidth*2 < x && self.launchPad_position_x+buttonwidth*3 > x{
                //(4,2)
                return "Tap9"
            }
        }
        
        return "NO"
    }
    
}

class EndNode{
    var screenSize : CGSize
    var score : String
    
    init(_ score:String,screensize:CGSize) {
        self.screenSize = screensize
        self.score = score
    }
    
    func showScore(_ comment:String)->[SKLabelNode]{
        let labe1Title = SKLabelNode()
        labe1Title.text = score
        labe1Title.fontSize = 40
        labe1Title.zPosition = Layer.touch
        labe1Title.position = CGPoint(x: self.screenSize.width/2, y: self.screenSize.height-labe1Title.fontSize)
        let labetComment = SKLabelNode()
        labetComment.text = comment
        labetComment.fontSize = 15
        labetComment.zPosition = Layer.touch
        labetComment.position = CGPoint(x: self.screenSize.width/2, y: self.screenSize.height-labe1Title.fontSize-labetComment.fontSize)
        return [labe1Title,labetComment]
    }
}
