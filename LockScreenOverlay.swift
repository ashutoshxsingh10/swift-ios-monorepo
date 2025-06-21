import SwiftUI

struct LockScreenOverlay: View {
    @EnvironmentObject private var drag: DragProgress       // 0‥1

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Clock + date
                VStack(spacing: 4) {
                    Text(Date.now, format: .dateTime.weekday().month().day())
                        .font(.system(size: 18, weight: .medium))
                        .opacity(0.85)

                    Text(timeString)
                        .font(.system(size: 96, weight: .semibold))
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, geo.safeAreaInsets.top + 100)   // (60+40)

                // Flashlight & camera buttons
                HStack {
                    LockButton(symbol: "flashlight.off.fill")
                    Spacer()
                    LockButton(symbol: "camera.fill")
                }
                .padding(.horizontal, 36)
                .padding(.bottom, geo.safeAreaInsets.bottom + 18)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .foregroundStyle(.white)
            .offset(y: -drag.value * (geo.size.height + geo.safeAreaInsets.top))
        }
        .ignoresSafeArea()
    }

    private var timeString: String {
        let c = Calendar.current.dateComponents([.hour, .minute], from: Date())
        return String(format: "%d:%02d", c.hour ?? 9, c.minute ?? 41)
    }
}

private struct LockButton: View {
    let symbol: String
    var body: some View {
        Button {} label: {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 48, height: 48)
                .overlay(Image(systemName: symbol)
                            .font(.system(size: 24, weight: .medium)))
        }
    }
}
