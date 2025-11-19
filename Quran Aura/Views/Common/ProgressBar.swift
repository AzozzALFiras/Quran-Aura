import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white.opacity(0.3))
                
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(width: geometry.size.width * CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)))
            }
            .cornerRadius(2)
        }
    }
}