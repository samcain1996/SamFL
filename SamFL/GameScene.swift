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
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Welcome") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.init(named: "welcome_fadein")!]))
        }
        
        self.samFace = self.childNode(withName: "//Sam") as? SKSpriteNode
        if let samFace = self.samFace {
            samFace.alpha = 0.0
            samFace.size = CGSize(width: 10, height: 10)
            
            if let samText = samFace.childNode(withName: "//SamFL_Label") as? SKLabelNode {
                samText.alpha = samText.parent!.alpha
            }
            
        }
    }
    
    
    func startGame() {
        
        if let view = self.view {
            if let fieldScene = FieldScene(fileNamed: "FieldScene") {
                fieldScene.scaleMode = .aspectFill
                fieldScene.entities = entities
                fieldScene.graphs = graphs
                view.presentScene(fieldScene)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let samFace = self.samFace {
            if let samText = samFace.childNode(withName: "//SamFL_Label") as? SKLabelNode {
                samText.run(SKAction.init(named: "sam_zoom")!)
                samFace.run(SKAction.init(named: "sam_zoom")!)
                samFace.run(SKAction.sequence([SKAction.playSoundFileNamed("SamFL_short.mp3", waitForCompletion: false),
                                               SKAction.wait(forDuration: 5)]), completion: startGame)
            }
        }
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
