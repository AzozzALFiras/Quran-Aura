import SwiftUI

struct SurahsListView: View {
    let surahs: [Surah]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var searchText = ""
    @State private var selectedReciter: Reciter?
    @State private var showingReciterPicker = false
    
    var filteredSurahs: [Surah] {
        if searchText.isEmpty {
            return surahs
        }
        return surahs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredSurahs) { surah in
            SurahRow(
                surah: surah,
                audioPlayer: audioPlayer,
                appData: appData,
                showingFullPlayer: $showingFullPlayer
            )
        }
        .listStyle(PlainListStyle())
        .background(AppConfig.shared.primaryGradient)
        .navigationTitle(AppConfig.shared.strings.surahs)
        .searchable(text: $searchText, prompt: AppConfig.shared.strings.searchSurahs)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingReciterPicker = true
                } label: {
                    HStack {
                        Image(systemName: "person.wave.2")
                        Text(selectedReciter?.name ?? "اختر قارئ")
                            .font(.caption)
                    }
                    .foregroundColor(.appPrimary)
                }
            }
        }
        .alert("اختر قارئ", isPresented: $showingReciterPicker) {
            ForEach(getSampleReciters()) { reciter in
                Button(reciter.name) {
                    selectedReciter = reciter
                }
            }
            Button(AppConfig.shared.strings.cancel, role: .cancel) { }
        } message: {
            Text("يرجى اختيار قارئ لتشغيل السورة")
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
    
    private func getSampleReciters() -> [Reciter] {
        return [
            Reciter(name: "علي بن عبد الرحمن الحذيفي", href: "https://server9.mp3quran.net/hthfi/", image: "https://i.pinimg.com/564x/96/3d/1e/963d1e668b2d18aeb0e46ae657b5affa.jpg"),
            Reciter(name: "سعد الغامدي", href: "https://server7.mp3quran.net/s_gmd/", image: "https://i.pinimg.com/564x/85/27/cf/8527cf694f379425e43b9a4fe54b6cfb.jpg"),
            Reciter(name: "مشاري العفاسي", href: "https://server8.mp3quran.net/afs/", image: "https://static.suratmp3.com/pics/reciters/thumbs/62_600_600.jpg")
        ]
    }
}