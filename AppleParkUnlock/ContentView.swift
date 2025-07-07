import SwiftUI

struct ContentView: View {
    @StateObject private var drag = DragProgress()          // unlock progress
    @State private var dragBase: CGFloat = 0
    @GestureState      private var isDragging = false       // finger down?
    @State private var showPicker = true
    @State private var selectedLocation = defaultLocations.first!

    var body: some View {
       ZStack(alignment: .bottom) {
             EiffelMap(location: $selectedLocation)
             LockScreenOverlay()
             HomeDock()
         }
        .fullScreenCover(isPresented: $showPicker) {
            LocationSelectionView(selection: $selectedLocation,
                                  isPresented: $showPicker,
                                  locations: defaultLocations)
        }

        .environmentObject(drag)
        .gesture(
          DragGesture()
            .onChanged { value in
              // When the finger first touches the screen, capture the current progress
              // we detect “first touch” by seeing that translation is still near zero.
              if abs(value.translation.height) < 1 {
                dragBase = drag.value
              }

              // Compute how far the finger has moved as a fraction of screen height:
              // upward swipe = negative height → +progress
              // downward swipe = positive height → –progress
              let delta = -value.translation.height / UIScreen.main.bounds.height

              // New candidate progress, clamped 0…1
              let p = min(max(dragBase + delta, 0), 1)
              drag.update(p)
            }
            .onEnded { value in
              // On lift, decide if we should snap all the way open (1) or closed (0).
              // Use predictedEndTranslation so a quick flick downward will lock again.
              let deltaEnd = -value.predictedEndTranslation.height / UIScreen.main.bounds.height
              let predicted = dragBase + deltaEnd
              let shouldUnlock = predicted > 0.4

              withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                drag.update(shouldUnlock ? 1 : 0)
              }
            }
        )
        .environmentObject(drag).gesture(
            DragGesture()
              .onChanged { value in
                // When the finger first touches the screen, capture the current progress
                // we detect “first touch” by seeing that translation is still near zero.
                if abs(value.translation.height) < 1 {
                  dragBase = drag.value
                }

                // Compute how far the finger has moved as a fraction of screen height:
                // upward swipe = negative height → +progress
                // downward swipe = positive height → –progress
                let delta = -value.translation.height / UIScreen.main.bounds.height

                // New candidate progress, clamped 0…1
                let p = min(max(dragBase + delta, 0), 1)
                drag.update(p)
              }
              .onEnded { value in
                // On lift, decide if we should snap all the way open (1) or closed (0).
                // Use predictedEndTranslation so a quick flick downward will lock again.
                let deltaEnd = -value.predictedEndTranslation.height / UIScreen.main.bounds.height
                let predicted = dragBase + deltaEnd
                let shouldUnlock = predicted > 0.4

                withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                  drag.update(shouldUnlock ? 1 : 0)
                }
              }
          )
          .environmentObject(drag)
    }
}
