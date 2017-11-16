//
//  GameScene.swift
//  IShipIt
//
//  Created by student on 11/9/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var shipNode: ShipNode!
    var waveBaseNode: WaveNode!
    var isHolding = true
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        physicsBody!.collisionBitMask = PhysicsCategory.Ship
        
        enumerateChildNodes(withName: "//*", using: {node, _ in
            if let customNode = node as?CustomNodeEvents {
                customNode.didMoveToScene()
            }
        })
        
        shipNode = childNode(withName: "//ship_body") as! ShipNode
        waveBaseNode = childNode(withName: "wave_base") as! WaveNode
        //print(shipNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHolding = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //isHolding = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //isHolding = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        shipNode.zRotation = MotionMonitor.Instance.rotation
        
        if isHolding {
            shipNode.physicsBody?.applyImpulse(CGVector(dx:0, dy: 10))
            //shipNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy:0))
        }
        
        var position = waveBaseNode.position
        position.x -= CGFloat(0.8)
        waveBaseNode.position = position
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA:SKPhysicsBody
        let bodyB:SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
            bodyB = contact.bodyA
            bodyA = contact.bodyB
        } else {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        }
        
        if (bodyA.categoryBitMask == PhysicsCategory.Ship &&
            bodyB.categoryBitMask == PhysicsCategory.Wave) {
            let degree = atan2(contact.contactNormal.dy, contact.contactNormal.dx) - CGFloat.pi / 2
            print("boat: \(shipNode.zRotation) degree: \(degree)");
        }
    }
}
