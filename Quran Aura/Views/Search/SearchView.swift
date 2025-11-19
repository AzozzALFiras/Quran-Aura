import SwiftUI

struct SearchView: View {
    let reciters: [Reciter]
    let surahs: [Surah]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var searchText = ""
    
    var filteredSurahs: [Surah] {
        if searchText.isEmpty { return [] }
        return surahs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var filteredReciters: [Reciter] {
        if searchText.isEmpty { return [] }
        return reciters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack {
            if searchText.isEmpty {
                List {
                    if !appData.favoriteSurahs.isEmpty {
                        Section(AppConfig.shared.strings.favoriteSurahsSection) {
                            ForEach(appData.favoriteSurahs) { surah in
                                SurahRow(
                                    surah: surah,
                                    audioPlayer: audioPlayer,
                                    appData: appData,
                                    showingFullPlayer: $showingFullPlayer
                                )
                            }
                        }
                    }
                    
                    if !appData.favoriteReciters.isEmpty {
                        Section(AppConfig.shared.strings.favoriteRecitersSection) {
                            ForEach(appData.favoriteReciters) { reciter in
                                ReciterRow(reciter: reciter, appData: appData)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                List {
                    if !filteredSurahs.isEmpty {
                        Section(AppConfig.shared.strings.searchSurahs) {
                            ForEach(filteredSurahs) { surah in
                                SurahRow(
                                    surah: surah,
                                    audioPlayer: audioPlayer,
                                    appData: appData,
                                    showingFullPlayer: $showingFullPlayer
                                )
                            }
                        }
                    }
                    
                    if !filteredReciters.isEmpty {
                        Section(AppConfig.shared.strings.searchReciters) {
                            ForEach(filteredReciters) { reciter in
                                ReciterRow(reciter: reciter, appData: appData)
                            }
                        }
                    }
                    
                    if filteredSurahs.isEmpty && filteredReciters.isEmpty {
                        Section {
                            Text(AppConfig.shared.strings.noResults)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(AppConfig.shared.backgroundColor)
        .navigationTitle(AppConfig.shared.strings.search)
        .searchable(text: $searchText, prompt: AppConfig.shared.strings.searchPlaceholder)
    }
}