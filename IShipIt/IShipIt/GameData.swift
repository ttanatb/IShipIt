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
        static let backgroundColor = SKColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
    }
    
    
    struct scene {
        static let backgroundColor = SKColor(red: 0.118, green: 0.194, blue: 0.327, alpha: 0.4)
        static let mainBackgroundColor = SKColor(red: 0.254, green: 0.254, blue: 0.255, alpha: 0.2)
    }
}
