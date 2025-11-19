import SwiftUI

struct DuasView: View {
    @State private var categories: [DuaCategory] = []
    @State private var filteredCategories: [DuaCategory] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var hasLoadedData = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                AppConfig.shared.primaryGradient
                    .ignoresSafeArea()
                
                if isLoading && !hasLoadedData {
                    LoadingView()
                } else if let error = errorMessage {
                    ErrorView(error: error, retryAction: loadData)
                } else {
                    VStack(spacing: 0) {
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField(AppConfig.shared.strings.searchDuas, text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .environment(\.layoutDirection, .rightToLeft)
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(12)
                        .background(Color(.systemBackground).opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                // Header
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(AppConfig.shared.strings.duas)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(AppConfig.shared.textPrimary)
                                    
                                    Text(AppConfig.shared.strings.duasDescription)
                                        .font(.body)
                                        .foregroundColor(AppConfig.shared.textSecondary)
                                }
                                .padding(.horizontal)
                                
                                // Search results count
                                if !searchText.isEmpty {
                                    HStack {
                                        Text("\(filteredCategories.flatMap { $0.prayers }.count) \(AppConfig.shared.strings.searchResults)")
                                            .font(.caption)
                                            .foregroundColor(AppConfig.shared.textSecondary)
                                        
                                        Spacer()
                                        
                                        Button(AppConfig.shared.strings.cancelSearch) {
                                            searchText = ""
                                        }
                                        .font(.caption)
                                        .foregroundColor(.appPrimary)
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // Categories Grid
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(displayedCategories) { category in
                                        NavigationLink(destination: DuaCategoryView(category: category, searchText: searchText)) {
                                            CategoryCard(category: category)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                                
                                // Statistics
                                HStack {
                                    InfoCard(
                                        title: AppConfig.shared.strings.categories,
                                        value: "\(categories.count)",
                                        icon: "folder.fill",
                                        color: .appSecondary
                                    )
                                    InfoCard(
                                        title: AppConfig.shared.strings.duas,
                                        value: "\(categories.reduce(0) { $0 + $1.count })",
                                        icon: "text.book.closed",
                                        color: .green
                                    )
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                if !hasLoadedData {
                    loadData()
                }
            }
            .onChange(of: searchText) { _ in
                filterCategories()
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    private var displayedCategories: [DuaCategory] {
        searchText.isEmpty ? categories : filteredCategories
    }
    
    private func loadData() {
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchDuas { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let categories):
                    self.categories = categories
                    self.hasLoadedData = true
                case .failure(let error):
                    self.errorMessage = "\(AppConfig.shared.strings.loadError): \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func filterCategories() {
        guard !searchText.isEmpty else {
            filteredCategories = categories
            return
        }
        
        let searchLowercased = searchText.lowercased()
        
        filteredCategories = categories.compactMap { category in
            let filteredPrayers = category.prayers.filter { prayer in
                prayer.title.lowercased().contains(searchLowercased) ||
                prayer.text.lowercased().contains(searchLowercased)
            }
            
            if category.name.lowercased().contains(searchLowercased) || !filteredPrayers.isEmpty {
                return DuaCategory(
                    id: category.id,
                    name: category.name,
                    nameEn: category.nameEn,
                    count: filteredPrayers.count,
                    prayers: filteredPrayers
                )
            }
            
            return nil
        }
    }
}

struct CategoryCard: View {
    let category: DuaCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(AppConfig.shared.textPrimary)
                        .lineLimit(2)
                    
                    Text("\(category.count) \(AppConfig.shared.strings.dua)")
                        .font(.caption)
                        .foregroundColor(AppConfig.shared.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .font(.caption)
                    .foregroundColor(AppConfig.shared.textSecondary)
            }
            
            Text(category.nameEn)
                .font(.caption)
                .foregroundColor(AppConfig.shared.textSecondary.opacity(0.5))
        }
        .padding()
        .background(AppConfig.shared.cardBackgroundDua.opacity(0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(AppConfig.shared.textPrimary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(AppConfig.shared.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppConfig.shared.cardBackgroundDua.opacity(0.2))
        .cornerRadius(12)
    }
}