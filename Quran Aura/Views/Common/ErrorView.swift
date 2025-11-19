import SwiftUI

struct ErrorView: View {
    let error: String
    let retryAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                
                Text(error)
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("إعادة المحاولة", action: retryAction)
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
            }
            .padding()
        }
    }
}