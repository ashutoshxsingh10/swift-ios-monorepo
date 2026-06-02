import SwiftUI
import MapKit

struct LocationSelectionView: View {
    @Binding var selection: MapLocation
    @Binding var isPresented: Bool
    var locations: [MapLocation]

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(locations) { location in
                    ZStack(alignment: .bottom) {
                        Map(initialPosition: .camera(
                            MapCamera(centerCoordinate: location.coordinate,
                                      distance: 1000))) {
                            Marker(location.name, coordinate: location.coordinate)
                        }
                        .mapStyle(.standard(elevation: .realistic))
                        .tag(location)
                        .disabled(true)

                        Text(location.name)
                            .font(.title.bold())
                            .padding(12)
                            .background(.ultraThinMaterial, in: Capsule())
                            .padding(.bottom, 40)
                    }
                    .ignoresSafeArea()
                }
            }
            .tabViewStyle(PageTabViewStyle())

            Button("Select") { isPresented = false }
                .padding()
                .background(.ultraThinMaterial, in: Capsule())
                .padding(.bottom, 60)
        }
    }
}
