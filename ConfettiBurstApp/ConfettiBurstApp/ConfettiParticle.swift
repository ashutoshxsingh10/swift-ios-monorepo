import SwiftUI

struct ConfettiParticle: Identifiable {
    let id = UUID()
    let imageName: String
    var position: CGPoint
    var velocity: CGVector
    var rotation: Angle
    var angularVelocity: Double
    var scale: CGFloat
    var opacity: Double
    let baseSize: CGFloat  // ✅ Random size multiplier
    
    init(imageName: String, origin: CGPoint, powerMultiplier: CGFloat = 1.0, burstAngleRange: ClosedRange<CGFloat>? = nil) {
        self.imageName = imageName
        self.position = origin
        
        let angleRange = burstAngleRange ?? (-120...(-60))
        let angle = CGFloat.random(in: angleRange) * .pi / 180
        let speed = CGFloat.random(in: 400...700) * powerMultiplier
        
        self.velocity = CGVector(
            dx: cos(angle) * speed,
            dy: sin(angle) * speed
        )
        
        self.rotation = Angle(degrees: Double.random(in: 0...360))
        self.angularVelocity = Double.random(in: -720...720) * Double(powerMultiplier)
        self.scale = CGFloat.random(in: 0.8...1.2)
        self.opacity = 1.0
        
        // ✅ Changed from 1.0...3.0 to 0.7...2.0
        self.baseSize = CGFloat.random(in: 0.7...2.0)
    }
}
