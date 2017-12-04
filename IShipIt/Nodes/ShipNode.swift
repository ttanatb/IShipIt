//
//  ShipNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class ShipNode: SKSpriteNode, CustomNodeEvents {
    var people:[SKSpriteNode] = []
    var peopleOffset:[CGPoint] = []
    var dieAction:SKAction = SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 200.0), duration: TimeInterval(12.0)), SKAction.rotate(byAngle: CGFloat(999999), duration: TimeInterval(12.0))])
    
    var isDead = false
    var isInvulnerable = false;
    
    private var currHealth = 5
    
    let MAX_INVUL_TIMER:CGFloat = 2
    var timer:CGFloat = 0
    
    
    var health:Int {
        get { return currHealth }
        set (newValue) {
            if (!isInvulnerable && newValue < people.count) {
                currHealth = newValue;
                
                people[currHealth].physicsBody?.isDynamic = true
                people[currHealth].physicsBody?.applyImpulse(CGVector.random() * 200)
                people[currHealth].physicsBody?.applyAngularImpulse(CGFloat.random(min: -300, max: 300))
                
                if currHealth < 1 {
                    isDead = true
                }
                
                isInvulnerable = true
                timer = MAX_INVUL_TIMER
                self.color = UIColor.red
            }
        }
    }
    
    func didMoveToScene() {
        physicsBody?.categoryBitMask = PhysicsCategory.Ship
        physicsBody?.collisionBitMask = PhysicsCategory.Wave
        physicsBody?.contactTestBitMask = PhysicsCategory.Wave
        
        //print(dieAction)
        
        for var node in self.children {
            node.physicsBody?.collisionBitMask = PhysicsCategory.None
            node.physicsBody?.categoryBitMask = PhysicsCategory.None
            
            people.append((node as? SKSpriteNode)!)
            peopleOffset.append(node.position)
        }
        
        //print(people.count)
    }
    
    func update(dt: CGFloat) {
        if isDead {return}
        
        if (isInvulnerable) {

            timer -= dt
            
            if (timer < CGFloat(0)) {
                self.color = UIColor.white;
                isInvulnerable = false;
            }
            
        }
        
        for index in 0..<currHealth {
            people[index].position = peopleOffset[index];
        }
        
        zRotation = MotionMonitor.Instance.rotation
    }
}

