import SwiftUI
import RiveRuntime

struct ContentView: View {
    // Load only artboard “2” from your .riv
    private let riveModel = RiveViewModel(
        fileName: "flower_randomizer",
        artboardName: "2"
    )

    var body: some View {
        ZStack {
            // pure black background edge-to-edge
            Color.black
                .ignoresSafeArea()

            // scaled to fit the view bounds
            riveModel.view()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
