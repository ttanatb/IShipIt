//
//  WaveNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class WaveNode: SKSpriteNode, CustomNodeEvents {
    var frontWave:SKSpriteNode? = nil
    var backWave:SKSpriteNode? = nil
    
    func didMoveToScene() {
        physicsBody?.categoryBitMask = PhysicsCategory.Wave
        physicsBody?.collisionBitMask = PhysicsCategory.Ship
        physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        
        print(self.children.count)
        
        if self.children.count > 0 {
            frontWave = children[0] as? SKSpriteNode
        }
        
        if self.children.count > 1 {            
            backWave = children[1] as? SKSpriteNode
        }
    
        //frontWave = childNode(withName: "wave_Secondary")! as? SKSpriteNode
    }
    
    func update() {
        //print("x: \(MotionMonitor.Instance.rotX) y: \(MotionMonitor.Instance.rotY)")
        frontWave?.position = CGPoint(x: MotionMonitor.Instance.rotX, y: MotionMonitor.Instance.rotY) * 10
        backWave?.position = CGPoint(x: MotionMonitor.Instance.rotX, y: MotionMonitor.Instance.rotY) * -15
        
    }
}
