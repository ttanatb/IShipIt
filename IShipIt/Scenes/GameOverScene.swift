//
//  GameOverScene.swift
//  IShipIt
//
//  Created by student on 11/13/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit
class GameOverScene: SKScene {
    // MARK: - ivars -
    let sceneManager:GameViewController
    let button:SKLabelNode = SKLabelNode(fontNamed: GameData.font.mainFont)
    var score:Int = 0
    
    // MARK: - Initialization -
    init(size: CGSize, sceneManager:GameViewController, score: Int) {
        self.sceneManager = sceneManager
        super.init(size: size)
        self.score = score
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func didMove(to view: SKView){
        backgroundColor = GameData.scene.backgroundColor
        
        let label = SKLabelNode(fontNamed: GameData.font.mainFont)
        label.text = "Game Over"
        label.fontColor = UIColor.red
        label.fontSize = 100
        label.position = CGPoint(x:size.width/2, y:size.height/2 + 200)
        addChild(label)
        
        let label2 = SKLabelNode(fontNamed: GameData.font.mainFont)
        label2.text = " \(score) points!"
        label2.fontSize = 70
        label2.position = CGPoint(x:size.width/2, y:size.height/2 - 100)
        addChild(label2)
        
        let label4 = SKLabelNode(fontNamed: GameData.font.mainFont)
        label4.text = "Tap to play again"
        label4.fontSize = 70
        label4.position = CGPoint(x:size.width/2, y:size.height/2 - 300)
        addChild(label4)
        
        // logo
        var texture:SKSpriteNode
        texture = SKSpriteNode(imageNamed: "boat")
        texture.setScale(0.02)
        texture.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 70)
        addChild(texture)
        
    }
    
    
    // MARK: - Events -
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneManager.loadHomeScene()
    }
}



