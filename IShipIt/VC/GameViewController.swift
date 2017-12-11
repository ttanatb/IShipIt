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
    //MARK: iVars
    
    var skView: SKView!
    
    let screenSize = CGSize(width: 1080, height: 1920)
    let scaleMode = SKSceneScaleMode.aspectFill
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = self.view as! SKView

        loadHomeScene()
        
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = false
        skView.showsFPS = false
        skView.showsNodeCount = false
        self.becomeFirstResponder()
    }
    
    //MARK: Functions
    
    //home screen
    func loadHomeScene() {
        let scene = HomeScene(size:screenSize, scaleMode:scaleMode, sceneManager: self)
        scene.scaleMode = .aspectFit
        scene.size = skView.bounds.size
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene, transition: reveal)
    }
    
    //game screen
    func loadGameScene() {
        if let scene = SKScene(fileNamed: "GameScene") {
            MotionMonitor.Instance.startUpdates()
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            if let gameScene = scene as? GameScene {
                gameScene.setViewController(viewController: self)
            }
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(scene)
            }
            

        }
    }
    
    //instructions screens
    func loadInstructionsScene() {
        let scene = InstructionsScene(size: screenSize, sceneManager: self)
        scene.scaleMode = .aspectFit
        scene.size = skView.bounds.size
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene, transition: reveal)
    }
    
    //gameover screen
    func loadGameOverScene(score:Int) {
        MotionMonitor.Instance.stopUpdates()
        
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
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
