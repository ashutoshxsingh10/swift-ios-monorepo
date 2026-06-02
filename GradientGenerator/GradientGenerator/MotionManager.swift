import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var gravity = CGPoint(x: 0, y: 0)
    @Published var rotation = CGPoint(x: 0, y: 0)
    
    init() {
        startMotionUpdates()
    }
    
    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 FPS
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let motion = motion, error == nil else { return }
            
            // Get gravity (device tilt)
            let gravityX = motion.gravity.x
            let gravityY = motion.gravity.y
            
            // Get rotation rate
            let rotationX = motion.rotationRate.x
            let rotationY = motion.rotationRate.y
            
            // Smooth the values
            self?.gravity = CGPoint(
                x: gravityX * 0.3 + (self?.gravity.x ?? 0) * 0.7,
                y: gravityY * 0.3 + (self?.gravity.y ?? 0) * 0.7
            )
            
            self?.rotation = CGPoint(
                x: rotationX * 0.3 + (self?.rotation.x ?? 0) * 0.7,
                y: rotationY * 0.3 + (self?.rotation.y ?? 0) * 0.7
            )
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
