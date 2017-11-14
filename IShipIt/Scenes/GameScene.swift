//
//  GameScene.swift
//  IShipIt
//
//  Created by student on 11/9/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let sceneManager:GameViewController
    
    init(size: CGSize, scaleMode:SKSceneScaleMode, sceneManager:GameViewController) {
        self.sceneManager = sceneManager
        var texture = SKTexture(imageNamed: "boat")
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let boat = SKSpriteNode(imageNamed: "boat")
        var boatPos:CGPoint = CGPoint(x:10, y:10)
        boat.setScale(0.5)
        boatPos = CGPoint(x: size.width/2 - 100, y: size.height - 400)
        boat.position = boatPos
        addChild(boat)

    }
}
