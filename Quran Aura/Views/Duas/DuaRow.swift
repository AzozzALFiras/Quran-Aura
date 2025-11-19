import SwiftUI

struct DuaRow: View {
    let dua: Dua
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with title and number
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(dua.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(AppConfig.shared.textPrimary)
                        .lineLimit(2)
                    
                    Text("\(AppConfig.shared.strings.dua) \(dua.id)")
                        .font(.caption)
                        .foregroundColor(AppConfig.shared.textSecondary)
                }
                
                Spacer()
                
                // Number badge
                Text("\(dua.id)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(AppConfig.shared.textPrimary)
                    .frame(width: 24, height: 24)
                    .background(Circle().fill(Color.appPrimary))
            }
            
            // Dua text preview
            Text(dua.text)
                .font(.body)
                .foregroundColor(AppConfig.shared.textSecondary)
                .lineSpacing(4)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // Tap hint
            HStack {
                Spacer()
                Text("انقر لعرض التفاصيل")
                    .font(.caption2)
                    .foregroundColor(AppConfig.shared.textSecondary.opacity(0.5))
                Image(systemName: "chevron.left")
                    .font(.caption2)
                    .foregroundColor(AppConfig.shared.textSecondary.opacity(0.5))
            }
        }
        .padding(16)
        .background(AppConfig.shared.cardBackgroundDua.opacity(0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}