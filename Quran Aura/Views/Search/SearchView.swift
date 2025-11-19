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
                        Section("السور المفضلة") {
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
                        Section("القراء المفضلون") {
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
                        Section("السور") {
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
                        Section("القراء") {
                            ForEach(filteredReciters) { reciter in
                                ReciterRow(reciter: reciter, appData: appData)
                            }
                        }
                    }
                    
                    if filteredSurahs.isEmpty && filteredReciters.isEmpty {
                        Section {
                            Text("لا توجد نتائج")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color(.systemBackground))
        .navigationTitle("بحث")
        .searchable(text: $searchText, prompt: "ابحث عن سورة أو قارئ...")
    }
}