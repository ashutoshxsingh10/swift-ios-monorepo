import SwiftUI

struct HomeDock: View {
    @EnvironmentObject private var drag: DragProgress    // 0‥1 unlock progress
    private var unlocked: Bool { drag.value >= 0.90 }    // reveal threshold

    // PNG icons you added to Assets.xcassets
    private let icons = ["dock_phone", "dock_messages",
                         "dock_safari", "dock_camera"]

    var body: some View {
        // Aligns the dock to the very bottom of the Z-stack in ContentView
        VStack {
            Spacer(minLength: 0)

            HStack(spacing: 16) {                        // gap between icons
                ForEach(icons, id: \.self) { name in
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity,
                               minHeight: 64, maxHeight: 64) // 44-pt icons
                }
            }
            .padding(.vertical, 12)                      // inner top/bottom pad
            .padding(.horizontal, 20)                    // inner side pad
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 26,
                                             style: .continuous))
            .padding(.horizontal, 16)                    // outer side margins
            .padding(.bottom, 16)                        // outer bottom margin
            .opacity(unlocked ? 1 : 0)                   // hidden while locked
            .offset(y: unlocked ? 0 : 140)               // slide up from bottom
            .animation(.easeOut(duration: 0.35), value: unlocked)
        }
        .ignoresSafeArea(.keyboard)                      // stay above keyboard
    }
}
