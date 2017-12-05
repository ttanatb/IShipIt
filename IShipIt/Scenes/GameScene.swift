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
    var waves:[WaveNode] = [];
    var shipCamera: SKCameraNode!
    var cameraOffset:CGPoint!
    var camStartingYPos:CGFloat!
    
    var isHolding = true
    
    var isTooMuch = false
    let fallThreshold:CGFloat = 0.35
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var viewController:GameViewController? = nil
    
    var score:CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        let backgroundMusic = SKAudioNode(fileNamed: "TitanicRecorderTheme")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        physicsWorld.contactDelegate = self
        
        enumerateChildNodes(withName: "//*", using: {node, _ in
            if let customNode = node as?CustomNodeEvents {
                customNode.didMoveToScene()
            }
            
            if node.name == "wave_base" {
                let wave = node as! WaveNode
                self.waves.append(wave)
            }
        })
        
        shipNode = childNode(withName: "//ship_body") as! ShipNode
        shipCamera = childNode(withName: "shipCamera") as! SKCameraNode
        cameraOffset = (camera?.position)! - shipNode.position
        camStartingYPos = (camera?.position)!.y
    }
    
    func setViewController(viewController: GameViewController) {
        self.viewController = viewController;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //isHolding = true
        shipNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat(0), dy: CGFloat(2000)))
        //print(shipNode.physicsBody!.velocity)
        
        //shipNode.health -= 1
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
        
        calculateDeltaTime(currentTime: currentTime)
        let deltaTime = CGFloat(dt)
        
        for var wave in waves { wave.update() }
        shipNode.update(dt: deltaTime)
        
        if (camera?.position.x)! > waves[0].position.x + waves[0].size.width {
            waves[0].position = waves[1].position + CGPoint(x: waves[0].size.width, y: CGFloat(0))
            let wave = waves[0]
            waves[0] = waves[1]
            waves[1] = wave
        }
        
        var camPos = CGPoint(x: shipNode.position.x, y: shipCamera.position.y)
        camPos.x = shipNode.position.x + cameraOffset.x
        if (shipNode.position.y < CGFloat(2500)) {
            camPos.y = shipNode.position.y + cameraOffset.y;
        }
        
        shipCamera.position = camPos
        
        if camPos.y > CGFloat(320) {
            let scale = (camPos.y - CGFloat(320)) * CGFloat(0.0045) + CGFloat(1)
            if scale < CGFloat(8) {
                shipCamera.setScale(scale)
            }
        }
        
        score += deltaTime * CGFloat(3)
        
    }
    
    func calculateDeltaTime(currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
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
            
            shipNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat(2000), dy: CGFloat(2000)))
            
            let degree = atan2(contact.contactNormal.dy, contact.contactNormal.dx) - CGFloat.pi / 2
            if abs(degree) > CGFloat(0.4) {
                if abs(degree - shipNode.zRotation) > fallThreshold {
                    shipNode.health -= 1;
                    if (shipNode.health < 1) {
                        viewController?.loadGameOverScene(score: Int(score))
                    }
                }
            } else {
                if abs(degree - shipNode.zRotation) > fallThreshold * 2 {
                    shipNode.health -= 1;
                    if (shipNode.health < 1) {
                        viewController?.loadGameOverScene(score: Int(score))
                    }
                }
            }
        }
    }
}
