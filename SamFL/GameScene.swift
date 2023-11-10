//
//  GameScene.swift
//  SamFL
//
//  Created by Sam Cain on 11/10/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var samFace : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    private var initialized = false
    private var isPlayingSong = false
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Welcome") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.init(named: "welcome_fadein")!]), completion: { self.initialized = true })
        }
        
        self.samFace = self.childNode(withName: "//Sam") as? SKSpriteNode
        if let samFace = self.samFace {
            samFace.alpha = 0.0
            samFace.size = CGSize(width: 10, height: 10)
            
            if let samText = samFace.childNode(withName: "//SamFL_Label") as? SKLabelNode {
                samText.alpha = samText.parent!.alpha
            }
            
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//            
//            //n.run(SKAction.playSoundFileNamed("SamFL.mp3", waitForCompletion: false))
//        }

    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (!self.initialized) { return }
        
        if let samFace = self.samFace {
            if (!samFace.hasActions()) { samFace.run(SKAction.playSoundFileNamed("SamFL.mp3", waitForCompletion: true)) }
            samFace.run(SKAction.init(named: "sam_zoom")!)
            if let samText = samFace.childNode(withName: "//SamFL_Label") as? SKLabelNode {
                samText.run(SKAction.init(named: "sam_zoom")!)
            }
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
