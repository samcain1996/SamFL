//
//  FieldScene.swift
//  SamFL
//
//  Created by Sam Cain on 11/10/23.
//

import SpriteKit
import GameplayKit

class FieldScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var scroll = false
    private var scrollDir: CGFloat = 1
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        let cameraNode = SKCameraNode()
            
        self.addChild(cameraNode)
        self.camera = cameraNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            scroll = !scroll
            if (!scroll) { continue }
            
            scrollDir = touch.location(in: self.view).y > self.size.height / 2 ? -8 : 8
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
    
        if (scroll) {
            if let pos = self.camera?.position {
                self.camera?.position = CGPoint(x: pos.x, y: pos.y + scrollDir)
            }
        }
        
        self.lastUpdateTime = currentTime
    }
}

