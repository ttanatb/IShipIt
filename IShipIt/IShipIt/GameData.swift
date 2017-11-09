//
//  GameData.swift
//  IShipIt
//
//  Created by student on 11/9/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import SpriteKit

struct GameData{
    init(){
        fatalError("The GameData struct is a singleton")
    }
    
    struct font{
        static let mainFont = "AppleSDGothicNeo-Regular"
    }
    
    struct hud{
        static let backgroundColor = SKColor(red: 0.2, green: 0.39, blue: 0.80, alpha: 1.0)
        
    }
    
    
    struct scene {
        static let backgroundColor = SKColor(red: 0.2, green: 0.39, blue: 0.80, alpha: 1.0)
    }
}
