import SwiftUI

struct RecitersListView: View {
    let reciters: [Reciter]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @State private var searchText = ""
    
    var filteredReciters: [Reciter] {
        if searchText.isEmpty {
            return reciters
        }
        return reciters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredReciters) { reciter in
            NavigationLink {
                ReciterDetailView(
                    reciter: reciter,
                    audioPlayer: audioPlayer,
                    appData: appData,
                    showingFullPlayer: $showingFullPlayer
                )
            } label: {
                ReciterRow(reciter: reciter, appData: appData)
            }
            .listRowBackground(AppConfig.shared.cardBackground)
        }
        .listStyle(PlainListStyle())
        .background(AppConfig.shared.primaryGradient)
        .navigationTitle(AppConfig.shared.strings.reciters)
        .searchable(text: $searchText, prompt: AppConfig.shared.strings.searchReciters)
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
}