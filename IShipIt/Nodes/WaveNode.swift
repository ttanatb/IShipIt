//
//  WaveNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class WaveNode: SKSpriteNode, CustomNodeEvents {
    func didMoveToScene() {
        physicsBody?.categoryBitMask = PhysicsCategory.Wave
        physicsBody?.collisionBitMask = PhysicsCategory.Ship
    }
}
