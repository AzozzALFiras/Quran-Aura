import SwiftUI

struct ReciterDetailView: View {
    let reciter: Reciter
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var surahs: [Surah] = []
    @State private var isLoading = true
    @State private var searchText = ""
    
    var filteredSurahs: [Surah] {
        if searchText.isEmpty {
            return surahs
        } else {
            return surahs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                RemoteImage(
                    url: reciter.secureImage,
                    placeholder: "person.circle.fill",
                    width: 120,
                    height: 120,
                    cornerRadius: 60
                )
                
                Text(reciter.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppConfig.shared.textPrimary)
                
                Text("قارئ قرآن كريم")
                    .font(.body)
                    .foregroundColor(AppConfig.shared.textSecondary)
            }
            .padding()
            .background(AppConfig.shared.cardBackground)
            .cornerRadius(12)
            .padding(.horizontal)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.2)
                    .padding()
            } else if surahs.isEmpty {
                Text("لا توجد سور متاحة")
                    .foregroundColor(AppConfig.shared.textSecondary)
                    .padding()
            } else {
                List(filteredSurahs) { surah in
                    Button {
                        audioPlayer.playSurah(surah, for: reciter)
                        showingFullPlayer = true
                    } label: {
                        HStack {
                            Text(surah.formattedNumber)
                                .font(.caption)
                                .foregroundColor(AppConfig.shared.textPrimary)
                                .frame(width: 30, height: 30)
                                .background(Circle().fill(Color.appPrimary))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(surah.name)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(AppConfig.shared.textPrimary)
                                
                                Text("سورة رقم \(surah.number)")
                                    .font(.caption)
                                    .foregroundColor(AppConfig.shared.textSecondary)
                            }
                            
                            Spacer()
                            
                            if audioPlayer.isLoading && audioPlayer.currentSurah?.id == surah.id {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .tint(.appPrimary)
                            } else {
                                Image(systemName: "play.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.appPrimary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .disabled(audioPlayer.isLoading)
                }
                .searchable(text: $searchText, prompt: AppConfig.shared.strings.searchSurahs)
                .listStyle(PlainListStyle())
            }
        }
        .background(AppConfig.shared.primaryGradient)
        .navigationTitle(reciter.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    toggleFavorite(reciter: reciter)
                } label: {
                    Image(systemName: isFavorite(reciter: reciter) ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite(reciter: reciter) ? .red : .appPrimary)
                }
            }
        }
        .onAppear {
            loadSurahs()
        }
        .alert(AppConfig.shared.strings.playbackError, isPresented: .constant(audioPlayer.errorMessage != nil)) {
            Button(AppConfig.shared.strings.ok, role: .cancel) {
                audioPlayer.errorMessage = nil
            }
        } message: {
            if let error = audioPlayer.errorMessage {
                Text(error)
            }
        }
    }
    
    private func loadSurahs() {
        isLoading = true
        NetworkService.shared.fetchSurahs { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let surahs):
                    self.surahs = surahs
                case .failure:
                    self.surahs = []
                }
                self.isLoading = false
            }
        }
    }
    
    private func isFavorite(reciter: Reciter) -> Bool {
        appData.favoriteReciters.contains { $0.id == reciter.id }
    }
    
    private func toggleFavorite(reciter: Reciter) {
        if let index = appData.favoriteReciters.firstIndex(where: { $0.id == reciter.id }) {
            appData.favoriteReciters.remove(at: index)
        } else {
            appData.favoriteReciters.append(reciter)
        }
    }
}