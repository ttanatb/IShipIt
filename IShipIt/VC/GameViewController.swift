//
//  GameViewController.swift
//  IShipIt
//
//  Created by student on 11/9/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var skView: SKView!
    
    let screenSize = CGSize(width: 1080, height: 1920)
    let scaleMode = SKSceneScaleMode.aspectFill
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = self.view as! SKView

        // Load the SKScene from 'GameScene.sks'
        loadHomeScene()
        //loadGameScene()
        
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        self.becomeFirstResponder()
    }
    
    func loadHomeScene() {
        let scene = HomeScene(size:screenSize, scaleMode:scaleMode, sceneManager: self)
        scene.scaleMode = .aspectFit
        scene.size = skView.bounds.size
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene, transition: reveal)
    }
    
    func loadGameScene() {
        
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(scene)
            }
            
            MotionMonitor.Instance.startUpdates()
        } else {
//            let gameScene = GameScene(size:screenSize, scaleMode: scaleMode,  sceneManager: self)
//
//            gameScene.scaleMode = .aspectFit
//            gameScene.size = skView.bounds.size
//            
//            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1)
//            skView.presentScene(gameScene, transition: reveal)
        }
        
    }
    
    func loadInstructionsScene() {
        let scene = InstructionsScene(size: screenSize, sceneManager: self)
        scene.scaleMode = .aspectFit
        scene.size = skView.bounds.size
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene, transition: reveal)
    }
    
    func loadGameOverScene(score:Int) {
        let scene = GameOverScene(size:screenSize, sceneManager: self, score: score)
        scene.scaleMode = .aspectFit
        scene.size = skView.bounds.size
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene, transition: reveal)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
