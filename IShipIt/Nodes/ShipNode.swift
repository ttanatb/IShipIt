//
//  ShipNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class ShipNode: SKSpriteNode, CustomNodeEvents {
    
    //MARK: iVars
    var people:[SKSpriteNode] = []
    var peopleOffset:[CGPoint] = []
    var emitter:SKEmitterNode? = nil
    
    var isDead = false
    var isInvulnerable = false;
    
    let MAX_INVUL_TIMER:CGFloat = 2
    var timer:CGFloat = 0
    
    //diffculties
    var rotClamp:[CGFloat] = [0.75, 0.85, 0.95]
    var sensitvity:[CGFloat] = [7.5, 7.25, 7.0]
    var xForce:[CGFloat] = [1500, 2500, 3500]

    //MARK: Properties
    private var currHealth = 5
    var health:Int {
        get { return currHealth }
        set (newValue) {
            if (!isInvulnerable && newValue < people.count) {
                currHealth = newValue;
                
                people[currHealth].physicsBody?.isDynamic = true
                people[currHealth].physicsBody?.applyImpulse(CGVector(dx:0, dy:0.5))
                people[currHealth].physicsBody?.applyAngularImpulse(CGFloat.random(min: -30, max: 30))
                
                if currHealth < 1 {
                    isDead = true
                }
                
                isInvulnerable = true
                timer = MAX_INVUL_TIMER
                self.color = UIColor.red
            }
        }
    }
    
    
    //MARK: Init logic
    func didMoveToScene() {
        physicsBody?.categoryBitMask = PhysicsCategory.Ship
        physicsBody?.collisionBitMask = PhysicsCategory.Wave
        physicsBody?.contactTestBitMask = PhysicsCategory.Wave
        
        for node in self.children {
            if node is SKEmitterNode {
                continue
            }
            
            node.physicsBody?.collisionBitMask = PhysicsCategory.None
            node.physicsBody?.categoryBitMask = PhysicsCategory.Person
            
            people.append((node as? SKSpriteNode)!)
            peopleOffset.append(node.position)
        }
        
        //emitter = childNode(withName: "Jet") as? SKEmitterNode
        emitter = SKEmitterNode(fileNamed: "Jet")
        emitter?.position = CGPoint(x: -4, y: -50)
        emitter?.zPosition = -4
        parent?.addChild(emitter!)
    }
    
    //MARK: Update Loop
    func update(dt: CGFloat, difficulty: Int) {
        if isDead {return}
        
        //move it to the right
        physicsBody?.applyForce(CGVector(dx: xForce[difficulty], dy:0))
        if (physicsBody?.velocity.dx)! < CGFloat(5) {
            physicsBody?.applyImpulse(CGVector(dx: 2000, dy: 2000))
        }
        
        //adjust emitter speed
        emitter?.particleSpeed = (physicsBody?.velocity.dx)! / 2
        emitter?.position = self.position + CGPoint(x: -4, y: -50)
        emitter?.zRotation = self.zRotation
        
        //update invulnerability
        if (isInvulnerable) {
            timer -= dt
            
            if (timer < CGFloat(0)) {
                self.color = UIColor.white;
                isInvulnerable = false;
            }
        }
        
        //update passenger pos
        for index in 0..<currHealth {
            people[index].position = peopleOffset[index];
        }
        
        
        //update rotation
        let currRot = MotionMonitor.Instance.rotation / sensitvity[difficulty]
        zRotation += currRot

        let clamp = rotClamp[difficulty]
        if zRotation > clamp {
            zRotation = clamp
        } else if zRotation < -clamp {
            zRotation = -clamp
        }
    }
}

