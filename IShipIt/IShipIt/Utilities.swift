//
//  Utilities.swift
//  IShipIt
//
//  Created by student on 11/9/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import CoreGraphics

struct PhysicsCategory {
    static let None     : UInt32 = 0x1 << 0
    static let Ship     : UInt32 = 0x1 << 1
    static let Wave     : UInt32 = 0x1 << 2
    static let Edge     : UInt32 = 0x1 << 3
    static let All      : UInt32 = UINT32_MAX
}

struct SpriteLayer {
    static let Background   : CGFloat = 0
    static let BackWave     : CGFloat = 1
    static let Sprites      : CGFloat = 2
    static let Foreground   : CGFloat = 3
    static let HUD          : CGFloat = 4
}
