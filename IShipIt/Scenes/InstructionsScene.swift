//
//  InstructionsScene.swift
//  IShipIt
//
//  Created by student on 11/13/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit
class InstructionsScene: SKScene {
    // MARK: - ivars -
    let sceneManager:GameViewController
    let button:SKLabelNode = SKLabelNode(fontNamed: GameData.font.mainFont)
    var touchCount = 0
    var texture:SKSpriteNode
    
    // MARK: - Initialization -
    init(size: CGSize, sceneManager:GameViewController) {
        self.sceneManager = sceneManager
        texture = SKSpriteNode(imageNamed: "instructions1")
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func didMove(to view: SKView){
//        let defaults = UserDefaults.standard
//        defaults.set(0, forKey: "HighScore")
            
        backgroundColor = GameData.scene.backgroundColor
        
        //texture.size = self.size
        texture.setScale(0.58)
        texture.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(texture)
    }
    
    
    // MARK: - Events -
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.playSoundFileNamed("splash", waitForCompletion: false))
        touchCount += 1
        if touchCount == 1 {
            texture.texture = SKTexture(imageNamed: "instructions2")
        } else {
            sceneManager.loadHomeScene()
        }
    }
}



