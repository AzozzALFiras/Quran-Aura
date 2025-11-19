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
                    .foregroundColor(.white)
                
                Text("قارئ قرآن كريم")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.2)
                    .padding()
            } else if surahs.isEmpty {
                Text("لا توجد سور متاحة")
                    .foregroundColor(.white.opacity(0.7))
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
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Circle().fill(Color.purple))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(surah.name)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Text("سورة رقم \(surah.number)")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            if audioPlayer.isLoading && audioPlayer.currentSurah?.id == surah.id {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .tint(.purple)
                            } else {
                                Image(systemName: "play.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .disabled(audioPlayer.isLoading)
                }
                .searchable(text: $searchText, prompt: "ابحث عن سورة...")
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle(reciter.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    toggleFavorite(reciter: reciter)
                } label: {
                    Image(systemName: isFavorite(reciter: reciter) ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite(reciter: reciter) ? .red : .purple)
                }
            }
        }
        .onAppear {
            loadSurahs()
        }
        .alert("خطأ في التشغيل", isPresented: .constant(audioPlayer.errorMessage != nil)) {
            Button("حسناً", role: .cancel) {
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
