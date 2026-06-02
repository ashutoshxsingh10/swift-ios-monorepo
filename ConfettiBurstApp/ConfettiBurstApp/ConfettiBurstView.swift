import SwiftUI

struct ConfettiBurstView: View {
    @State private var particles: [ConfettiParticle] = []
    @State private var timer: Timer?
    @State private var screenBounds: CGRect = .zero
    @State private var tapCount: Int = 0
    @State private var fillPercentage: CGFloat = 0.0
    
    private let confettiAssets = [
        "element1", "element2", "element3", "element4", "element5",
        "element6", "element7", "element8", "element9", "element10"
    ]
    
    // Physics constants
    private let gravity: CGFloat = 980
    private let velocityFriction: CGFloat = 0.99
    private let angularFriction: CGFloat = 0.98
    private let frameRate: Double = 1.0 / 60.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color.black
                    .ignoresSafeArea()
                
                // Confetti particles layer
                ForEach(particles) { particle in
                    Image(particle.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 40 * particle.baseSize,   // ✅ Apply random size
                            height: 40 * particle.baseSize
                        )
                        .rotationEffect(particle.rotation)
                        .scaleEffect(particle.scale)
                        .opacity(particle.opacity)
                        .position(particle.position)
                }
                
                // Centered briefcase button
                BriefcaseButton(
                    action: { isPowerBurst in
                        handleTap(
                            isPowerBurst: isPowerBurst,
                            at: CGPoint(
                                x: geometry.size.width / 2,
                                y: geometry.size.height / 2
                            )
                        )
                    },
                    currentFill: fillPercentage
                )
                
                // Debug UI (optional)
                VStack {
                    HStack {
                        Text("Taps: \(tapCount)/10")
                        Text("Fill: \(Int(fillPercentage * 100))%")
                        Text("Particles: \(particles.count)")
                    }
                    .foregroundColor(.white)
                    .opacity(0.4)
                    .padding(8)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(8)
                    .padding()
                    
                    Spacer()
                }
            }
            .onAppear {
                screenBounds = geometry.frame(in: .global)
                startAnimationLoop()
            }
            .onDisappear {
                stopAnimationLoop()
            }
        }
    }
    
    // ✅ Updated tap handler
    private func handleTap(isPowerBurst: Bool, at origin: CGPoint) {
        if isPowerBurst {
            // ✅ POWER BURST: 4x particles in ALL DIRECTIONS (360°)
            let powerBurstCount = Int.random(in: 16...24)  // 4x more (was 4-6)
            
            print("💥💥💥💥 OMNIDIRECTIONAL POWER BURST! \(powerBurstCount) particles")
            
            for _ in 0..<powerBurstCount {
                guard let assetName = confettiAssets.randomElement() else { continue }
                
                // ✅ Full 360° burst range
                let particle = ConfettiParticle(
                    imageName: assetName,
                    origin: origin,
                    powerMultiplier: 2.0,
                    burstAngleRange: -180...180  // All directions!
                )
                
                particles.append(particle)
            }
            
            // Reset counter
            tapCount = 0
            fillPercentage = 0.0
            
        } else {
            // Normal upward burst
            let burstCount = Int.random(in: 4...6)
            
            for _ in 0..<burstCount {
                guard let assetName = confettiAssets.randomElement() else { continue }
                
                let particle = ConfettiParticle(
                    imageName: assetName,
                    origin: origin,
                    powerMultiplier: 1.0,
                    burstAngleRange: nil  // Uses default upward fan
                )
                
                particles.append(particle)
            }
            
            // Increment tap counter
            tapCount += 1
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                fillPercentage = min(CGFloat(tapCount) / 10.0, 1.0)
            }
        }
        
        // Limit total particles
        if particles.count > 150 {  // Increased limit for power burst
            particles.removeFirst(particles.count - 150)
        }
    }
    
    private func startAnimationLoop() {
        timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
            updateParticles()
        }
    }
    
    private func stopAnimationLoop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateParticles() {
        let deltaTime = CGFloat(frameRate)
        
        particles = particles.compactMap { particle in
            var updated = particle
            
            // Apply gravity
            updated.velocity.dy += gravity * deltaTime
            
            // Apply friction
            updated.velocity.dx *= velocityFriction
            updated.velocity.dy *= velocityFriction
            
            // Update position
            updated.position.x += updated.velocity.dx * deltaTime
            updated.position.y += updated.velocity.dy * deltaTime
            
            // Update rotation
            updated.rotation += Angle(degrees: updated.angularVelocity * Double(deltaTime))
            updated.angularVelocity *= angularFriction
            
            // Fade out near edges
            let distanceFromBottom = screenBounds.height - updated.position.y
            let distanceFromTop = updated.position.y
            let distanceFromSides = min(
                updated.position.x,
                screenBounds.width - updated.position.x
            )
            
            // Fade when approaching any edge
            if distanceFromBottom < 200 || distanceFromTop < 100 || distanceFromSides < 50 {
                let fadeProgress = min(
                    distanceFromBottom / 200,
                    distanceFromTop / 100,
                    distanceFromSides / 50
                )
                updated.opacity = max(0, Double(fadeProgress))
            }
            
            // Remove particles that are off-screen
            if updated.position.y > screenBounds.height + 100 ||
               updated.position.y < -100 ||
               updated.position.x < -100 ||
               updated.position.x > screenBounds.width + 100 {
                return nil
            }
            
            return updated
        }
    }
}

struct ConfettiBurstView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiBurstView()
    }
}
