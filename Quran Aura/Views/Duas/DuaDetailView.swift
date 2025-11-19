import SwiftUI

struct DuaDetailView: View {
    let dua: Dua
    @Environment(\.presentationMode) var presentationMode
    @State private var showingShareSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                AppConfig.shared.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(AppConfig.shared.strings.dua) \(dua.id)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(AppConfig.shared.textPrimary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(Color.appPrimary))
                                
                                Spacer()
                            }
                            
                            Text(dua.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                        
                        // Dua Text
                        VStack(alignment: .leading, spacing: 12) {
                            Text("\(AppConfig.shared.strings.duaText):")
                                .font(.headline)
                                .foregroundColor(AppConfig.shared.textSecondary)
                            
                            Text(dua.text)
                                .font(.body)
                                .foregroundColor(AppConfig.shared.textPrimary)
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .background(AppConfig.shared.cardBackgroundDua.opacity(0.2))
                        .cornerRadius(12)
                        
                        // Explanation if available
                        if let explanation = dua.longExplanation, !explanation.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("\(AppConfig.shared.strings.details):")
                                    .font(.headline)
                                    .foregroundColor(AppConfig.shared.textSecondary)
                                
                                Text(explanation)
                                    .font(.body)
                                    .foregroundColor(AppConfig.shared.textPrimary)
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                            .background(AppConfig.shared.cardBackgroundDua.opacity(0.2))
                            .cornerRadius(12)
                        }
                        
                        // Share Button
                        Button(action: {
                            showingShareSheet = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text(AppConfig.shared.strings.shareDua)
                            }
                            .font(.headline)
                            .foregroundColor(AppConfig.shared.textPrimary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appPrimary)
                            .cornerRadius(12)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(AppConfig.shared.strings.close) {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(AppConfig.shared.textPrimary)
            )
            .sheet(isPresented: $showingShareSheet) {
                ShareSheet(activityItems: [shareableText])
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    private var shareableText: String {
        """
        \(dua.title)
        
        \(dua.text)
        
        \(dua.longExplanation ?? "")
        
        شارك عبر تطبيق Quran Aura
        """
    }
}