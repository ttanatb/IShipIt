//
//  WaveNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class WaveNode: SKSpriteNode, CustomNodeEvents {
    //MARK: iVars
    
    var texture1:SKTexture? = nil
    var shadowTexture1:SKTexture? = nil
    
    var texture2:SKTexture? = nil
    var shadowTexture2:SKTexture? = nil
    
    var shadowNode:SKSpriteNode? = nil
    
    var usingOne:Bool = true
    
    
    //MARK: Init logic
    func didMoveToScene() {
        //physics set up
        physicsBody?.categoryBitMask = PhysicsCategory.Wave
        physicsBody?.collisionBitMask = PhysicsCategory.Ship
        physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        
        //texture set up
        texture1 = SKTexture(imageNamed: "wave")
        shadowTexture1 = SKTexture(imageNamed: "waves1_shadow")
        texture2 = SKTexture(imageNamed: "waves2")
        shadowTexture2 = SKTexture(imageNamed: "waves2_shadow")
        
        //var set up
        if self.children.count > 0 {
            shadowNode = children[0] as? SKSpriteNode
        }
        
        switchWave()
    }
    
    //switches wave graphic randomly
    func switchWave() {
        if arc4random_uniform(1) == 0 {
            if !usingOne {
                usingOne = true
                self.texture = texture1
                shadowNode?.texture = shadowTexture1
            }
        } else {
            if usingOne {
                usingOne = false
                self.texture = texture2
                shadowNode?.texture = shadowTexture2
            }
        }
    }
}
