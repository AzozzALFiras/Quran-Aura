import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.purple)
                
                Text("جاري التحميل...")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
}