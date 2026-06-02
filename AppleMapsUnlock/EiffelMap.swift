import SwiftUI
import MapKit

// ➊ file‐level constant
private let startHeading: Double = -180   // 15° east of north

struct EiffelMap: View {
    @EnvironmentObject private var drag: DragProgress
    @Binding var location: MapLocation
    @State private var cameraPos: MapCameraPosition

    init(location: Binding<MapLocation>) {
        self._location = location
        _cameraPos = State(initialValue: .camera(
            MapCamera(centerCoordinate: location.wrappedValue.coordinate,
                      distance: 1000,
                      heading: startHeading,
                      pitch: 0)
        ))
    }

    var body: some View {
        Map(position: $cameraPos, interactionModes: [])
            .mapStyle(.standard(elevation: .realistic))
            .preferredColorScheme(.dark)
            .ignoresSafeArea()
            .onChange(of: drag.value) { updateCamera($0) }
            .onChange(of: location) { _ in resetCamera() }
    }

    private func updateCamera(_ t: CGFloat) {
        let finalHeading: Double = -10
        let heading = startHeading + (finalHeading - startHeading) * Double(t)
        let cam = MapCamera(centerCoordinate: location.coordinate,
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

    private func resetCamera() {
        cameraPos = .camera(
            MapCamera(centerCoordinate: location.coordinate,
                      distance: 1000,
                      heading: startHeading,
                      pitch: 0)
        )
    }
}
