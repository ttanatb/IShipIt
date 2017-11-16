//
//  MotionMonitor.swift
//  IShipIt
//
//  Created by Residence Halls Association on 11/15/17.
//  Copyright © 2017 TanatAndSneha. All rights reserved.
//

import Foundation
import CoreMotion
import CoreGraphics

class MotionMonitor {
    static let Instance = MotionMonitor()
    let manager = CMMotionManager()
    
    var rotation:CGFloat = 0
    var gravityVecNormalized = CGVector.zero
    var gravityVec = CGVector.zero
    var transform = CGAffineTransform(rotationAngle: 0)
    
    private init() { }
    
    func startUpdates() {
        if manager.isDeviceMotionAvailable {
            print ("** starting motion updates **")
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {
                data, error in
                guard data != nil else {
                    print("There was an error: \(error)")
                    return
                }
                
                self.rotation = CGFloat(atan2(data!.gravity.x, data!.gravity.y)) - CGFloat.pi
                self.gravityVecNormalized = CGVector(dx:CGFloat(data!.gravity.x), dy:CGFloat(data!.gravity.y))
                self.gravityVec = CGVector(dx:CGFloat(data!.gravity.x), dy:CGFloat(data!.gravity.y)) * 9.8
                
                self.transform = CGAffineTransform(rotationAngle: CGFloat(self.rotation))
                print("self.rotation = \(self.rotation)")
                print("self.gravityVectorNormalized = \(self.gravityVecNormalized)")
            }
        } else {
            print("Device Motion is not available! Are you on the simulator?")
        }
    }
    
    func stopUpdates() {
        print("** stopping motion updates **")
        if (manager.isDeviceMotionAvailable) {
            manager.stopDeviceMotionUpdates()
        }
    }
}
