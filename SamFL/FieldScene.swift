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
    private var field : SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        self.field = self.childNode(withName: "//field") as? SKSpriteNode
        if let field = self.field {
            field.alpha = 1.0
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
 
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

