import SwiftUI

struct SurahRow: View {
    let surah: Surah
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var selectedReciter: Reciter?
    @State private var showingReciterPicker = false
    @State private var showingShareSheet = false
    
    var body: some View {
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
                
                Text("سورة مكية • \(getVerseCount(surahNumber: surah.number)) آية")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button {
                    toggleFavorite(surah: surah)
                } label: {
                    Image(systemName: isFavorite(surah: surah) ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite(surah: surah) ? .red : .white)
                }
                
                Button {
                    showingShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                }
                
                Button {
                    if let reciter = selectedReciter {
                        audioPlayer.playSurah(surah, for: reciter)
                        showingFullPlayer = true
                    } else {
                        showingReciterPicker = true
                    }
                } label: {
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
                .disabled(audioPlayer.isLoading)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .alert("اختر قارئ", isPresented: $showingReciterPicker) {
            ForEach(getSampleReciters()) { reciter in
                Button(reciter.name) {
                    selectedReciter = reciter
                    audioPlayer.playSurah(surah, for: reciter)
                    showingFullPlayer = true
                }
            }
            Button("إلغاء", role: .cancel) { }
        } message: {
            Text("يرجى اختيار قارئ لتشغيل السورة")
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: ["استمع إلى سورة \(surah.name) من تطبيق القرآن الكريم"])
        }
    }
    
    private func getVerseCount(surahNumber: String) -> String {
        let verseCounts: [String: String] = [
            "001": "7", "002": "286", "003": "200", "004": "176", "005": "120",
            "006": "165", "007": "206", "008": "75", "009": "129", "010": "109"
        ]
        return verseCounts[surahNumber] ?? "---"
    }
    
    private func getSampleReciters() -> [Reciter] {
        return [
            Reciter(name: "علي بن عبد الرحمن الحذيفي", href: "https://server9.mp3quran.net/hthfi/", image: "https://i.pinimg.com/564x/96/3d/1e/963d1e668b2d18aeb0e46ae657b5affa.jpg"),
            Reciter(name: "سعد الغامدي", href: "https://server7.mp3quran.net/s_gmd/", image: "https://i.pinimg.com/564x/85/27/cf/8527cf694f379425e43b9a4fe54b6cfb.jpg"),
            Reciter(name: "مشاري العفاسي", href: "https://server8.mp3quran.net/afs/", image: "https://static.suratmp3.com/pics/reciters/thumbs/62_600_600.jpg")
        ]
    }
    
    private func isFavorite(surah: Surah) -> Bool {
        appData.favoriteSurahs.contains { $0.id == surah.id }
    }
    
    private func toggleFavorite(surah: Surah) {
        if let index = appData.favoriteSurahs.firstIndex(where: { $0.id == surah.id }) {
            appData.favoriteSurahs.remove(at: index)
        } else {
            appData.favoriteSurahs.append(surah)
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}