import SwiftUI
import MapKit

private let eiffelTower = CLLocationCoordinate2D(latitude: 37.81420,
                                                 longitude: -122.47795)


// ➊ file‐level constant
private let startHeading: Double = -180   // 15° east of north

struct EiffelMap: View {
    @EnvironmentObject private var drag: DragProgress
    @State private var cameraPos: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: eiffelTower,
                  distance: 1000,
                  heading: startHeading,  // OK, uses the file‐level constant
                  pitch: 0)
    )

    var body: some View {
        Map(position: $cameraPos, interactionModes: [])
            .mapStyle(.standard(elevation: .realistic))
            .preferredColorScheme(.dark)
            .ignoresSafeArea()
            .onChange(of: drag.value) { updateCamera($0) }
    }

    private func updateCamera(_ t: CGFloat) {
        let finalHeading: Double = -10
        let heading = startHeading + (finalHeading - startHeading) * Double(t)
        let cam = MapCamera(centerCoordinate: eiffelTower,
                            distance: 1000 - 450 * t,
                            heading: heading,
                            pitch: 55 * t)

        if drag.value < 1 {
            cameraPos = .camera(cam)
        } else {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.85)) {
                cameraPos = .camera(cam)
            }
        }
    }
}
