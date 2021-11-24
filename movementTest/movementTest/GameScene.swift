//
//  GameScene.swift
//  movementTest
//
//  Created by Goose on 5/24/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    var player : SKSpriteNode = SKSpriteNode()
    var player2 : SKSpriteNode = SKSpriteNode()
    
    var shardParticle : SKEmitterNode = SKEmitterNode()
    
    var sceneCamera : SKCameraNode = SKCameraNode()
    
    override func didMove(to view: SKView) {
        
        camera = sceneCamera
        
        
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 0, y: 0)
        self.addChild(player)
        
        player2 = SKSpriteNode(imageNamed: "player")
        player2.position = CGPoint(x: 50, y: 50)
        self.addChild(player2)
        
        shardParticle = SKEmitterNode(fileNamed: "IceShard")!
        self.addChild(shardParticle)
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.01
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
        
        player.removeAllActions()
        
        let movementSpeed = 200.0
        
        let x = pos.x - player.position.x
        let y = pos.y - player.position.y
        
        let distance = sqrt(x * x + y * y)
        
        player.run(SKAction.move(to: pos, duration: Double(distance) / movementSpeed))
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            print()
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        camera?.position.x = player.position.x
        camera?.position.y = player.position.y
    }
}
