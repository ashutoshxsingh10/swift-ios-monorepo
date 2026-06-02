import SwiftUI

struct GradientCanvasView: View {
    @Binding var canvas: Canvas
    let geometry: GeometryProxy
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Rectangle()
                .fill(Color.black)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .visualEffect { content, proxy in
                    content
                        .layerEffect(
                            ShaderLibrary.dynamicGradient(
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .data(canvas.shaderColorData),
                                .int(canvas.colors.count)
                            ),
                            maxSampleOffset: .zero
                        )
                }
        }
    }
}

// Extension to convert Canvas data to shader-compatible format
extension Canvas {
    struct ShaderColorData {
        var color: SIMD3<Float>
        var position: SIMD2<Float>
    }
    
    var shaderColorData: [ShaderColorData] {
        zip(colors, tapPositions).map { color, position in
            ShaderColorData(
                color: color,
                position: SIMD2<Float>(Float(position.x), Float(position.y))
            )
        }
    }
}
