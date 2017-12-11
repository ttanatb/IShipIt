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
    //MARK: iVars
    var shipNode: ShipNode!
    var waves:[WaveNode] = []
    var decorNodes:[DecorNode] = []
    
    var shipCamera: SKCameraNode!
    var cameraOffset:CGPoint!
    
    let fallThreshold:CGFloat = 0.325
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var viewController:GameViewController? = nil
    
    var score:CGFloat = 0
    var difficulty:Int = 0
    
    var scoreLabelNode:SKLabelNode? = nil
    var difficultyLabelNode:SKLabelNode? = nil
    let highScore = UserDefaults.standard.integer(forKey: "HighScore")
    var actionHasHappened = false
    
    override func didMove(to view: SKView) {
        run(SKAction.playSoundFileNamed("splash", waitForCompletion: false))
        
        backgroundColor = GameData.scene.mainBackgroundColor
        
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
            
            if node.name == "island" || node.name == "cloud" {
                let decor = node as! DecorNode
                self.decorNodes.append(decor)
            }
        })
        
        //instantiating variables
        difficultyLabelNode = childNode(withName: "//difficultyLabel") as? SKLabelNode
        scoreLabelNode = childNode(withName: "//scoreLabel") as? SKLabelNode
        shipNode = childNode(withName: "//ship_body") as! ShipNode
        shipCamera = childNode(withName: "shipCamera") as! SKCameraNode
        cameraOffset = (camera?.position)! - shipNode.position
        
        updateCamera()
    }
    
    func setViewController(viewController: GameViewController) {
        self.viewController = viewController;
    }
    
    //MARK: Update Logic
    
    override func update(_ currentTime: TimeInterval) {
        //delta time
        calculateDeltaTime(currentTime: currentTime)
        let deltaTime = CGFloat(dt)
        
        //update game objects
        shipNode.update(dt: deltaTime, difficulty: difficulty)
        updateWaves()
        updateDecor()
        updateCamera()
        updateScore(deltaTime: deltaTime)
        updateDifficulty()
    }
    
    func calculateDeltaTime(currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
    }
    
    func updateWaves() {
        //switches wave position
        if (camera?.position.x)! > waves[0].position.x + waves[0].size.width {
            waves[0].position = waves[1].position + CGPoint(x: waves[0].size.width, y: CGFloat(0))
            waves[0].switchWave()
            
            let wave = waves[0]
            waves[0] = waves[1]
            waves[1] = wave
        }
    }
    
    func updateDecor() {
        //puts them ahead of the camera if they are out of scene
        for decor in decorNodes {
            if decor.position.x + decor.size.width < (camera?.position.x)! - 3860 {
                decor.position = decor.position + CGPoint(x: CGFloat.random(min: 9800, max: 10200), y: CGFloat(0));
                decor.switchGraphic()
            }
        }
    }
    
    func updateCamera() {
        //update camera pos
        var camPos = CGPoint(x: shipNode.position.x, y: shipCamera.position.y)
        camPos.x = shipNode.position.x + cameraOffset.x
        
        //don't follow y-pos if it's wayyyy off-screen
        if (shipNode.position.y < CGFloat(2500)) {
            camPos.y = shipNode.position.y + cameraOffset.y;
        }
        
        shipCamera.position = camPos
        
        //scale up the camera if it's higher up
        if camPos.y > CGFloat(280) {
            let scale = (camPos.y - CGFloat(280)) * CGFloat(0.0045) + CGFloat(1)
            if scale < CGFloat(8) {
                shipCamera.setScale(scale)
            }
        }
    }
    
    func updateScore(deltaTime: CGFloat) {
        score += deltaTime * CGFloat(3)
        scoreLabelNode?.text = "Score: \(Int(score))"
        
        if Int(score) > highScore && !actionHasHappened {
            actionHasHappened = true
            scoreLabelNode?.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.scale(by: 2, duration: 2),
                SKAction.scale(by: 0.5, duration:2),
                ])))
        }
    }
    
    func updateDifficulty() {
        if difficulty < 2 && score > 200 {
            difficulty = 2
            difficultyLabelNode?.run(SKAction(named: "TextFade")!)
        }
        else if difficulty < 1 && score > 100 {
            difficulty = 1
            difficultyLabelNode?.run(SKAction(named: "TextFade")!)
        }
    }
    
    //MARK: Collision Resolution
    
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
            
            shipNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat(750), dy: CGFloat(0)))
            
            //calculate degree of impact
            let degree = atan2(contact.contactNormal.dy, contact.contactNormal.dx) - CGFloat.pi / 2
            
            //if it's within the easy to detect range
            if abs(degree) > CGFloat(0.50) {
                
                //should the ship take damage
                if abs(degree - shipNode.zRotation) > fallThreshold {
                    shipNode.health -= 1;
                    if (shipNode.health < 1) {
                        viewController?.loadGameOverScene(score: Int(score))
                    }
                }
            } else {
                
                //should the ship take damage
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
