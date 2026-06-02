import SwiftUI

struct NewCanvasModal: View {
    @Environment(\.dismiss) var dismiss
    let onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Create New Canvas?")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("This will create a new empty canvas above the current one.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                Button("Cancel") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.primary)
                .cornerRadius(12)
                
                Button("Create") {
                    onConfirm()
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding(24)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(40)
    }
}
