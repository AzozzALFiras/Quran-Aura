import SwiftUI

struct DuaCategoryView: View {
    let category: DuaCategory
    let searchText: String
    
    @State private var selectedDua: Dua?
    @State private var showingDuaDetail = false
    
    var filteredPrayers: [Dua] {
        if searchText.isEmpty {
            return category.prayers
        } else {
            let searchLowercased = searchText.lowercased()
            return category.prayers.filter { prayer in
                prayer.title.lowercased().contains(searchLowercased) ||
                prayer.text.lowercased().contains(searchLowercased)
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            AppConfig.shared.primaryGradient
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text(category.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppConfig.shared.textPrimary)
                        
                        Text(category.nameEn)
                            .font(.body)
                            .foregroundColor(AppConfig.shared.textSecondary)
                        
                        Text("\(filteredPrayers.count) \(AppConfig.shared.strings.dua)")
                            .font(.caption)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                    .padding(.horizontal)
                    
                    // Search results info
                    if !searchText.isEmpty {
                        HStack {
                            Text("\(filteredPrayers.count) \(AppConfig.shared.strings.searchResults) في \"\(searchText)\"")
                                .font(.caption)
                                .foregroundColor(AppConfig.shared.textSecondary)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    // Prayers List
                    LazyVStack(spacing: 12) {
                        ForEach(filteredPrayers) { dua in
                            DuaRow(dua: dua)
                                .onTapGesture {
                                    selectedDua = dua
                                    showingDuaDetail = true
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingDuaDetail) {
            if let dua = selectedDua {
                DuaDetailView(dua: dua)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}