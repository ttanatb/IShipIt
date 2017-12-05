//
//  HomeScene.swift
//  IShipIt
//
//  Created by student on 11/13/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit
class HomeScene:SKScene {
    //MARK: iVars
    let sceneManager:GameViewController
    let button:SKLabelNode = SKLabelNode(fontNamed: GameData.font.mainFont)
    
    // MARK: Init
    init(size: CGSize, scaleMode:SKSceneScaleMode, sceneManager:GameViewController) {
        self.sceneManager = sceneManager
        super.init(size: size)
        self.scaleMode = scaleMode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    // MARK: Helper functions for set up and input and touches
    override func didMove(to view: SKView) {
        backgroundColor = GameData.scene.backgroundColor
        
        //change this
        let label = SKLabelNode(fontNamed: GameData.font.mainFont)
        label.text = "I Ship It"
        label.position = CGPoint(x:size.width/2, y:size.height/2 + 100)
        label.fontSize = 175
        label.zPosition = 1
        addChild(label)
        
        // logo
        var texture:SKSpriteNode
        texture = SKSpriteNode(imageNamed: "boat")
        texture.setScale(0.02)
        texture.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(texture)

        
        //change this
        let label4 = SKLabelNode(fontNamed: GameData.font.mainFont)
        label4.text = "Tap to continue"
        //label4.fontColor = UIColor.init(red: 0.179, green: 0.222, blue: 0.232, alpha: 1.5)
        label4.fontSize = 55
        label4.position = CGPoint(x:size.width/2, y:size.height/2 - 300)
        addChild(label4)
        
        button.text = "Instructions"
        button.position = CGPoint(x:size.width/2, y: size.height/2 - 160)
        button.fontSize = 110
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if button.frame.contains(touch.location(in: self)) {
                sceneManager.loadInstructionsScene()
            } else {
                sceneManager.loadGameScene()
            }
            
            return
        }
    }
}
