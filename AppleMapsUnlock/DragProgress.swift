import SwiftUI

/// Shared 0‥1 value that mirrors the upward swipe
final class DragProgress: ObservableObject {
    @Published var value: CGFloat = 0             // 0 = locked, 1 = fully unlocked
    func update(_ raw: CGFloat) { value = min(max(raw, 0), 1) }
}
