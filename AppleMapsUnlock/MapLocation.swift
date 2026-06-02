import MapKit

struct MapLocation: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let defaultLocations: [MapLocation] = [
    MapLocation(name: "Apple Park", coordinate: .init(latitude: 37.3349, longitude: -122.0090)),
    MapLocation(name: "Eiffel Tower", coordinate: .init(latitude: 48.8584, longitude: 2.2945)),
    MapLocation(name: "Golden Gate", coordinate: .init(latitude: 37.8199, longitude: -122.4783))
]
