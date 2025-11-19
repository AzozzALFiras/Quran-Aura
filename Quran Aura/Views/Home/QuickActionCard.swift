import SwiftUI

struct QuickActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(AppConfig.shared.textPrimary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(AppConfig.shared.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
            }
            .padding()
            .background(AppConfig.shared.cardBackground)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}