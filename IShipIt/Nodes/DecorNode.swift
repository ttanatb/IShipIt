//
//  WaveNode.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

class DecorNode: SKSpriteNode, CustomNodeEvents {
    
    //MARK: iVars
    var textures:[SKTexture] = []
    var currIndex = 0
    
    //MARK: Init
    func didMoveToScene() {
        //loads textures it could switch between
        if (name?.contains("cloud"))! {
            textures.append(SKTexture(imageNamed: "cloud1"))
            textures.append(SKTexture(imageNamed: "cloud2"))
            textures.append(SKTexture(imageNamed: "cloud3"))
            textures.append(SKTexture(imageNamed: "cloud4"))
            zPosition = SpriteLayer.Foreground
            
        } else if (name?.contains("island"))! {
            textures.append(SKTexture(imageNamed: "island"))
            zPosition = SpriteLayer.Background
        }
        
        switchGraphic()
    }
    
    //MARK: Methods
    func switchGraphic() {
        //randomly chooses a different texture and flips it
        
        if textures.count > 1 {
            currIndex = Int(arc4random_uniform(UInt32(textures.count)))
        } else {
            currIndex = 0;
        }
        
        self.texture = textures[currIndex]
        self.xScale = -self.xScale
    }
}
