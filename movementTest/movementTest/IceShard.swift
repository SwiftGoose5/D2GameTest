//
//  IceShard.swift
//  movementTest
//
//  Created by Swift Goose on 12/14/21.
//

import SpriteKit
import GameplayKit

class IceShard: SKSpriteNode {
    let shardParticle = SKEmitterNode(fileNamed: "IceShard")!
    let shardFadeTime: Double = 0.1
    
    let shardRange: CGFloat = 600.0
    let shardSpeed: CGFloat = 600.0
    var shardDuration: CGFloat = 0.0
    
    var shardEndPoint = CGPoint()
    
    init(startPos: CGPoint, endPos: CGPoint) {
        super.init(texture: SKTexture(), color: .white, size: CGSize(width: 0, height: 0))
        
        position = startPos
        
        shardEndPoint = endPos
        
        let x = endPos.x - position.x
        let y = endPos.y - position.y
        
        let distance = sqrt(x * x + y * y)
        
        shardDuration = distance / shardSpeed
        
        addShardParticle()
        addShardActions()
    }
    
    func addShardParticle() {
        shardParticle.targetNode = self
        
        shardParticle.emissionAngle = CGFloat(-atan2(shardEndPoint.x - position.x,
                                                     shardEndPoint.y - position.y) - .pi/2)
        
        addChild(shardParticle)
    }
    
    func addShardActions() {
        let shardMove = SKAction.move(to: shardEndPoint, duration: Double(shardDuration))
        let shardFade = SKAction.fadeOut(withDuration: shardFadeTime)
        
        let rand = Int.random(in: 1...3)
        let shardSound = SKAction.playSoundFileNamed("icespike\(rand)", waitForCompletion: false)
        
        run(SKAction.sequence([shardSound, shardMove, shardFade, .removeFromParent()]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
