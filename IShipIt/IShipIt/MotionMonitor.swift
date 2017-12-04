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
    
    var timer:Timer!
    var rotX:CGFloat = 0
    var rotY:CGFloat = 0
    

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

                
                self.rotation = CGFloat(atan2(data!.gravity.x, data!.gravity.y)) + CGFloat.pi / 2
                self.gravityVecNormalized = CGVector(dx:CGFloat(data!.gravity.x), dy:CGFloat(data!.gravity.y))
                self.gravityVec = CGVector(dx:CGFloat(data!.gravity.x), dy:CGFloat(data!.gravity.y)) * 9.8
                
                self.transform = CGAffineTransform(rotationAngle: CGFloat(self.rotation))
                //print("self.rotation = \(self.rotation)")
                //print("self.gravityVectorNormalized = \(self.gravityVecNormalized)")
            }
        } else {
            print("Device Motion is not available! Are you on the simulator?")
        }
    
        if manager.isGyroAvailable {
            print ("** starting gyro updates **")
            manager.gyroUpdateInterval = 1.0 / 60.0
            manager.startGyroUpdates()
            
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats:true, block: { (timer) in
                if let data = self.manager.gyroData {
                    self.rotX = CGFloat(data.rotationRate.x)
                    self.rotY = CGFloat(data.rotationRate.y)
                }
            })
            
            RunLoop.current.add(self.timer!, forMode:.defaultRunLoopMode)
        } else {
            print("Gyro is not available! Are you on the simulator?")
        }
    
        
    }
    
    func stopUpdates() {
        print("** stopping motion updates **")
        if (manager.isDeviceMotionAvailable) {
            manager.stopDeviceMotionUpdates()
        }
        
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
            self.manager.stopGyroUpdates()
        }
    }
}
