import SwiftUI

struct BriefcaseButton: View {
    let action: (Bool) -> Void
    let currentFill: CGFloat  // 0.0 to 1.0
    
    @State private var isPressed = false
    
    // ✅ 40% larger sizes
    private let buttonSize: CGFloat = 112  // was 80, now 112 (40% increase)
    private let iconSize: CGFloat = 56     // was 40, now 56 (40% increase)
    
    var body: some View {
        Button(action: {
            let isPowerBurst = currentFill >= 1.0
            
            // Haptic feedback
            if isPowerBurst {
                let impact = UIImpactFeedbackGenerator(style: .heavy)
                impact.impactOccurred()
            } else {
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
            }
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            action(isPowerBurst)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
        }) {
            ZStack {
                // ✅ Base circle (dark background)
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: buttonSize, height: buttonSize)
                
                // ✅ Simple solid fill (grows from center)
                Circle()
                    .fill(Color.cyan.opacity(0.3))  // Light color visible on dark bg
                    .frame(
                        width: buttonSize * currentFill,
                        height: buttonSize * currentFill
                    )
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: currentFill)
                
                // ✅ Outer ring
                Circle()
                    .stroke(
                        currentFill >= 1.0 ? Color.cyan : Color.white.opacity(0.3),
                        lineWidth: currentFill >= 1.0 ? 4 : 2
                    )
                    .frame(width: buttonSize, height: buttonSize)
                
                // Briefcase icon
                Image("briefcase")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(currentFill >= 1.0 ? .cyan : .white)
            }
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .scaleEffect(currentFill >= 1.0 ? 1.1 : 1.0)
            .shadow(
                color: currentFill >= 1.0 ? Color.cyan.opacity(0.5) : Color.black.opacity(0.2),
                radius: currentFill >= 1.0 ? 20 : 10,
                x: 0,
                y: 5
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BriefcaseButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            BriefcaseButton(action: { _ in }, currentFill: 0.0)
            BriefcaseButton(action: { _ in }, currentFill: 0.5)
            BriefcaseButton(action: { _ in }, currentFill: 1.0)
        }
        .padding()
        .background(Color.black)
    }
}
