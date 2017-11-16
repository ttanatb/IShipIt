//
//  ShipNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class ShipNode: SKSpriteNode, CustomNodeEvents {
    func didMoveToScene() {
        physicsBody?.categoryBitMask = PhysicsCategory.Ship
        physicsBody?.collisionBitMask = PhysicsCategory.Wave | PhysicsCategory.Edge
    }
}

